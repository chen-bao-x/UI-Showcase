//
//  AllPropertys.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

class AllPropertys: ObservableObject {
    @Published var framePropertys = FramePropertys()
    @Published var boder = Border()
    
    class FramePropertys: ObservableObject {
        @Published var Width: CGFloat = 400
        
        @Published var Height: CGFloat = 400
        
        @Published var alignment: Alignment = .center
        
        @Published var selections: Int = 0 { didSet { alignment = a[selections] } }
        
        private var a: [Alignment] = [.leading, .trailing, .top,
                                      .topLeading, .topTrailing, .bottom,
                                      .bottomLeading, .bottomTrailing]
    }
    
    class Border: ObservableObject {
        @Published var WhetherShowBoder: Bool = false
        
        @Published var width: CGFloat = 5
        
        @Published var color: Color = .gray
        
        @Published var useImage: Bool = false
    }
}
