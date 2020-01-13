//
//  PopPhotoPicker.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/10.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import Photos
import SwiftUI

struct PopPhotoPicker: View {
    var a: PHFetchResult<PHAsset> = PhotoManager.SmartAlbums.recentlyAdded
    
    @State var selectedImages: [PHAsset] = []
    
    var body: some View {
        VStack {
            if !self.selectedImages.isEmpty {
                ForEach(0..<self.selectedImages.count, id: \.self) { i in
                    
                    HighQualityImage(asset: self.selectedImages[i])
                }
                
            } else {
                ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<self.a.count, id: \.self) { i in
                            
                            Selector(asset: self.a[i], i: i, selectedImages: self.$selectedImages)
                        }
                    }
                }
            }
        }
    }
    
    private let pub = PassthroughSubject<UIImage, Never>()
    
    struct Selector: View {
        let asset: PHAsset
        let i: Int
        
        @Binding var selectedImages: [PHAsset]
        
        @State private var select: Bool = false
        
        var body: some View {
            ZStack {
                CorneredImage(asset: self.asset)
                
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .frame(width: 100, height: 100)
                    .foregroundColor(
                        self.select ? Color.green : Color.clear
                    )
            }
            .onTapGesture(perform: self.f)
        }
        
        private func f() {
            self.select.toggle()
            
            if self.select {
                //                    self.s.selected.append(self.i)
                self.selectedImages.append(self.asset)
                
            } else {
                //                    self.s.selected.removeAll { self.i == $0 }
                self.selectedImages.removeAll { (p: PHAsset) -> Bool in
                    p == self.asset
                }
            }
            
            print(self.select)
        }
    }
}

struct CorneredImage: View {
    init(asset: PHAsset, size: CGSize = .init(width: 100, height: 100), img: Image? = nil) {
        self.asset = asset
        self.size = size
        
        self._img = .init(initialValue: img)
    }
    
    let asset: PHAsset
    
    let size: CGSize
    
    @State var img: Image? = nil
    
    var body: some View {
        VStack {
            (self.img ?? Image("p1"))
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                
                .onAppear(perform: self.f)
        }
        
        .frame(width: self.size.width, height: self.size.height)
        .cornerRadius(20)
        .clipped()
    }
    
    func f() {
        DispatchQueue.global().async {
            let size: CGSize = self.size
            
            PHCachingImageManager()
                .requestImage(for: self.asset,
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

struct HighQualityImage: View {
    let asset: PHAsset
    
    @State private var image: Image = Image("p1")
    
    var body: some View {
        self.image
            .resizable()
            .scaledToFit()
            .cornerRadius(20)
            .clipped()
            .onAppear {
                PhotoManager.highQualityImageRequester(asset: self.asset, pub: self.pub)
            }
            .onReceive(self.pub) { (u: UIImage) in
                self.image = Image(uiImage: u)
            }
    }
    
    let pub = PassthroughSubject<UIImage, Never>()
}
