//
//  NavigationLink_UIShowcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct NavigationLink_UIShowcase: View {
    var body: some View {
        NavigationLink(destination: "被弹出的页面") {
            "点击弹出页面"
                .modifier(bor())
        }
    }
}

struct NavigationLink_UIShowcase_Previews: PreviewProvider {
    static var previews: some View {
        NavigationLink_UIShowcase()
    }
}
