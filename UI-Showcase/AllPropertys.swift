//
//  AllPropertys.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

class AllPropertys: ObservableObject {
    @Published var framePropertys = frame()
    @Published var boder = Border()
}

extension AllPropertys {
    class frame: ObservableObject {
        @Published var setFrame: Bool = false
        
        @Published var Width: CGFloat = 0
        
        @Published var Height: CGFloat = 0
        
        @Published var alignment: Alignment = .center
        
        /// 主要是个 picker 用, 用 picker 来挑选 alignment 的值
        @Published var selection: Int = 5 { didSet {
            switch selection {
            case let x where x < 0:
                alignment = a[0]
                
            case let x where x > 8:
                alignment = a[8]
                
            default:
                alignment = a[selection]
            }
            
        } }
        
        private let a: [Alignment] = [.leading, .trailing, .top,
                                      .topLeading, .topTrailing, .center, .bottom,
                                      .bottomLeading, .bottomTrailing]
    }
}

extension AllPropertys {
    class Border: ObservableObject {
        @Published var WhetherShowBoder: Bool = false
        
        @Published var width: CGFloat = 5
        
        @Published var color: Color = .gray
        
        @Published var useImage: Bool = false
    }
}
