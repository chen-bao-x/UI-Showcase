//
//  PopPhotoPicker.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/10.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Photos
import SwiftUI

class selected: ObservableObject {
    @Published var selected: [Int] = [] {
        didSet {
            print(self.selected)
        }
    }
}

var S = selected()

struct PopPhotoPicker: View {
    var a: PHFetchResult<PHAsset> = PhotoManager.SmartAlbums.recentlyAdded
    
    @EnvironmentObject var s: selected
    
    var body: some View {
        VStack {
            if !self.s.selected.isEmpty { // 不佳这个 条件判断, 这个 Scrol View 就显示u吐出来.........
                ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(0..<self.s.selected.count, id: \.self) { i in
                            
                            Selector(asset: self.a[self.s.selected[i]], i: i)
                        }
                    }
                }
            }
            Text("hello")
            ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0..<self.a.count, id: \.self) { i in
                        
                        Selector(asset: self.a[i], i: i)
                    }
                }
            }
        }
    }
    
    struct Selector: View {
        let asset: PHAsset
        let i: Int
        
        @EnvironmentObject var s: selected
        
        @State private var select: Bool = false
        
        var body: some View {
            ZStack {
                SingleImage(a: asset)
                
                Image(systemName: "plus.circle.fill")
                    .font(.largeTitle)
                    .frame(width: 100, height: 100)
                    .foregroundColor(
                        self.select ? Color.green : Color.clear
                    )
            }
            .onTapGesture {
                self.select.toggle()
                
                if self.select {
                    self.s.selected.append(self.i)
                    
                } else {
                    self.s.selected.removeAll { (p) -> Bool in
                        self.i == p
                    }
                }
                
                print(self.select)
            }
        }
    }
}

// struct PopPhotoPicker_Previews: PreviewProvider {
//    static var previews: some View {
//        PopPhotoPicker()
//    }
// }
