//
//  PhotoManager.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/8.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import Foundation
import Photos
import SwiftUI

class PhotoManager: ObservableObject {
    @Published var 有权限么 = requestAuthorization()

    /// 所有的媒体
    static let allPhotos: PHFetchResult<PHAsset> = {
        let allPhotosOptions = PHFetchOptions()
        allPhotosOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        // 获取所有照片
        return PHAsset.fetchAssets(with: nil)

    }()

    /// 获取所有的智能相册, 也就是系统自己创建的 相册
    static let 智能相册 = PHAssetCollection
        .fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)

    /// 获取用户创建的所有相册
    /// 用 PHAsset.fetchAssets(in: PhotoManager.智能相册[i] 来获取里面的每一个 相册
    static let 用户创建的相册 = PHCollectionList
        .fetchTopLevelUserCollections(with: nil) as! PHFetchResult<PHAssetCollection>

    class SmartAlbums {
        /// 获取所有的智能相册, 也就是系统自己创建的 相册
        /// 用 PHAsset.fetchAssets(in: PhotoManager.智能相册[i] 来获取里面的每一个 相册
        static let all = PHAssetCollection
            .fetchAssetCollections(with: .album, subtype: .albumRegular, options: nil)

        static var recentlyAdded: PHFetchResult<PHAsset> {
            let a = PHAssetCollection
                .fetchAssetCollections(with: .smartAlbum, subtype: .smartAlbumRecentlyAdded, options: nil)

            if let b = a.lastObject {
                return PHAsset.fetchAssets(in: b, options: nil)
            }

            return PHFetchResult<PHAsset>()
        }
    }



    public static func fetchImagesFormAssets(assets: PHFetchResult<PHAsset>,
                                             pub: PassthroughSubject<Image, Never>) {
        if assets.count > 20 {
            (0..<50)
                .forEach { i in

                    fetchSingleImage(pub: pub, asset: assets[i])
                }

            DispatchQueue.global().async {
                (20..<assets.count)
                    .forEach { i in
                        fetchSingleImage(pub: pub, asset: assets[i])
                    }
            }

        } else {
            (0..<assets.count)
                .forEach { i in
                    fetchSingleImage(pub: pub, asset: assets[i])
                }
        }
    }

    /// 获取一个缩略图
    public static func fetchSingleImage(pub: PassthroughSubject<Image, Never>, asset: PHAsset, targetSize: CGSize? = nil) {
        PHCachingImageManager()
            .requestImage(for: asset,
                          targetSize: targetSize ?? CGSize(width: 80, height: 80),
                          contentMode: PHImageContentMode.aspectFill,
                          options: nil) { image, _ in
                if image != nil {
                    let a = Image(uiImage: image!)
                    DispatchQueue.main.async {
                        pub.send(a)
                    }
                }
            }
    }

//    static func allPhotosPublisher() -> Deferred<PassthroughSubject<Image, Never>> {
//        Deferred.init { () -> PassthroughSubject<Image, Never> in
//            let publisher = PassthroughSubject<Image, Never>()
//            fetchImagesFormAssets(assets: allPhotos, pub: publisher)
//            return publisher
//        }
//    }

//    static func singleImagePublisher(asset: PHAsset) -> Deferred<PassthroughSubject<Image, Never>> {
//        Deferred.init { () -> PassthroughSubject<Image, Never> in
//            let publisher = PassthroughSubject<Image, Never>()
    ////            fetchImagesFormAssets(assets: allPhotos, pub: publisher)
//
//            fetchSingleImage(pub: publisher, asset: asset)
//            return publisher
//        }
//    }

    /// Deferred<Publisher> 在被订阅是会执行  init 是创建的 createPublisher
//    static func singlePub(assets: PHFetchResult<PHAsset>) -> PassthroughSubject<Image, Never> {
//    static func singlePub(assets: PHFetchResult<PHAsset>) -> Deferred<PassthroughSubject<Image, Never>> {
//        Deferred.init { () -> PassthroughSubject<Image, Never> in
//            let publisher = PassthroughSubject<Image, Never>()
//            fetchImagesFormAssets(assets: assets, pub: publisher)
//            return publisher
//        }
//    }

    public class requestAuthorization: ObservableObject {
        @Published var vaule: Bool = false

        init() {
            PHPhotoLibrary.requestAuthorization { status in
                if status == .authorized {
                    self.vaule = true
                } else {
                    self.vaule = false
                }
            }
        }
    }

    /// 获取高清大图, 异步的
    /// - Parameters:
    ///   - pub: 获取到之后, 用这个发出来
    static func highQualityImageRequester(asset: PHAsset, pub: PassthroughSubject<UIImage, Never>) {
        let option = PHImageRequestOptions()
        option.resizeMode = .exact
        option.deliveryMode = .highQualityFormat

        // 默认是 false，表示 requestImageData() 方法是异步操作。如果设置成 true，这个就变成同步的了。
        // 注意：当 synchronous 设为 true 时，deliveryMode 属性就会被忽略，并被当作 .highQualityFormat 来处理。
        option.isSynchronous = false

        PHImageManager.default().requestImage(for: asset, targetSize: PHImageManagerMaximumSize, contentMode: .default, options: nil) { (img: UIImage?, _: [AnyHashable: Any]?) in
            if let g = img {
                pub.send(g)
            }
        }
    }
}
