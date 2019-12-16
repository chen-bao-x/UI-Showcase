//
//  UI_组件.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct UI_组件: View {
    var body: some View {
        可折叠Section(headerTitle: Text("UI 组件")) {
            NavigationLink(destination: imageScroll()) { "imageScroll" }
            NavigationLink(destination: diGui()) { "diGui" }
            NavigationLink(destination: coloringText()) { "coloringText" }
            NavigationLink(destination: 动态navigationBar()) { "动态navigationBar" }
            NavigationLink(destination: SwiftUIView()) { "SwiftUIView" }
            NavigationLink(destination: 折叠List()) { "折叠List" }
            NavigationLink(destination: segment()) { "segment" }
        }
    }
}

struct U_组件_Previews: PreviewProvider {
    static var previews: some View {
        UI_组件()
    }
}
