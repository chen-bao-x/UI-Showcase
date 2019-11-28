//
//  MenuButton_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

#if os(macOS)

import SwiftUI
struct MenuButton_UI_Showcase: View {
    var body: some View {
        MenuButton(label: "MenuButton") {
            "Button one"
            "Button weo"
        }
    }
}

struct MenuButton_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        MenuButton_UI_Showcase()
    }
}
#endif
