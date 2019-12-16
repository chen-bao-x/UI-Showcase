//
//  Photo.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/8.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import Photos
import SwiftUI

let p = PhotoManager()

public extension View {
    /// 基于 NavigationLink 跳转，但避免了因为出现在 List 中而出现详情指示器 `>`
    /// ，在 Cell 中调用即可实现跳转
    /// - Parameter destination: 要跳转的界面
    func navigationLink<Destination: View>(destination: Destination) -> some View {
        background(
            NavigationLink(destination: destination) {
                EmptyView() // 不需要实际的 Label 视图，EmtpyView 即可
            }
            .frame(width: 0, height: 0) // 避免占用空间
            .opacity(0) // 不可见
        )
    }
}

struct Photo: View {
    @EnvironmentObject var 有权限么: PhotoManager.requestAuthorization

    var body: some View {
        NavigationView {
            if self.有权限么.vaule {
                List {
                    NavigationLink(destination: PopPhotoPicker()
                        .environmentObject(S)) {
                        Text("PopPhotoPicker")
                    }
                    NavigationLink(destination: hehe(assets: PhotoManager.allPhotos)) {
                        Text("all Photos")
                    }

                    Section(header: Text("smartAlbums").font(.largeTitle)) {
                        ForEach(0..<PhotoManager.智能相册.count, id: \.self) { i in

                            // 一个 文件夹
                            NavigationLink(destination:
                                hehe(assets:
                                    PHAsset.fetchAssets(in: PhotoManager.智能相册[i], options: nil))) {
                                Text(PhotoManager.智能相册[i].localizedTitle ?? "")
                            }
                        }
                    }

                    Section(header: Text("userCollections").font(.largeTitle)) {
                        ForEach(0..<PhotoManager.用户创建的相册.count, id: \.self) { i in

                            // 一个 文件夹
                            NavigationLink(destination:
                                hehe(assets: PHAsset.fetchAssets(in: PhotoManager.用户创建的相册[i], options: nil))) {
                                Text(PhotoManager.用户创建的相册[i].localizedTitle ?? "")
                            }
                        }
                    }
                }

            } else {
                Button(action: { 打开当前app在设置app里面的设置页面() }) { Text("设置") }
            }
        }
        .navigationBarTitle(Text("Photos"))
    }
}

struct Photo_Previews: PreviewProvider {
    static var previews: some View {
        Photo()
    }
}

func 打开当前app在设置app里面的设置页面(打不开的话: @escaping () -> () = {}) {
    let settingUrl = URL(string: UIApplication.openSettingsURLString)!
    if UIApplication.shared.canOpenURL(settingUrl) {
        UIApplication.shared.openURL(settingUrl)
    } else {
        打不开的话()
    }
}

private let globalImage = Image("p1")

struct SingleImage: View {
    let a: PHAsset

    let size: CGSize? = nil

    @State var img: Image? = nil
    var body: some View {
        VStack {
            (self.img ?? globalImage)
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)

                .onAppear {
                    self.f()
                }
        }

        .frame(width: singleImageWidth, height: singleImageWidth)
        .clipped()
    }

    func f() {
        DispatchQueue.global().async {
            let size: CGSize
            if let s = self.size {
                size = s
            } else {
                size = CGSize(width: singleImageWidth, height: singleImageWidth)
            }

            PHCachingImageManager()
                .requestImage(for: self.a,
                              targetSize: size,
                              contentMode: .aspectFill,
                              options: nil) { uiImage, _ in

                    if let img = uiImage {
                        let a = resizeImage(image: img,
                                            targetSize: size)
                        let aa = Image(uiImage: a)
                        DispatchQueue.main.async {
                            self.img = aa
                        }
                    }
                }
        }
    }
}

var singleImageWidth: CGFloat = 100
struct hehe: View {
    init(assets: PHFetchResult<PHAsset>) {
        self.assets = assets

        let arr = (0..<assets.count).map { (i) -> PHAsset in
            assets[i]
        }

        self.二维数组 = 数组to二维数组(a: arr, b: 4)
    }

    var assets: PHFetchResult<PHAsset>

    var 二维数组: [[PHAsset]]

    var body: some View {
        GeometryReader { (g: GeometryProxy) -> Group<_ConditionalContent<List<Never, ForEach<Range<Int>, Int, hehe.row>>, Button<Text>>> in
            if singleImageWidth == 0 {
                singleImageWidth = g.size.width / 4
            }
            return Group {
                if self.有权限么.vaule {
                    List {
                        ForEach(0..<self.二维数组.count) { i in

                            row(ass: self.二维数组[i])
                        }
                    }

                } else {
                    Button(action: { 打开当前app在设置app里面的设置页面() }) { Text("设置") }
                }
            }
        }
    }

    struct row: View {
        let ass: [PHAsset]
        var body: some View {
            HStack(spacing: 1) {
                ForEach(0..<self.ass.count, id: \.self) { i in
                    SingleImage(a: self.ass[i])
                }
            }
            .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        }
    }

    @EnvironmentObject var 有权限么: PhotoManager.requestAuthorization
}

func 数组to二维数组<Value>(a: [Value], b: Int) -> [[Value]] {
    var resault: [[Value]] = []

    func hehe(i: Int) -> Int {
        let last = a.count - 1
        let end = (i + b)
        return end > last ? last : end
    }

    (0..<a.count).forEach { i in
        if i % b == 0 {
            resault
                .append(
                    Array(a[i...hehe(i: i)])
                )
        }
    }

    return resault
}

// TODO: 需要 裁切为 固定宽度的 正方形, 多余部分 裁掉--------------------------------
func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
    let rect = CGRect(x: 0, y: 0, width: targetSize.width, height: targetSize.height)

    UIGraphicsBeginImageContextWithOptions(targetSize, false, 1.0)

    image.draw(in: rect)
    let 裁切后的Image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()

    return 裁切后的Image ?? UIImage(named: "p1")!
}
