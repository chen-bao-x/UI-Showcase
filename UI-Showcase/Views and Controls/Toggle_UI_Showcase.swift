//
//  Toggle_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Toggle_UI_Showcase: View {
    @State private var isOn: Bool = true
    var body: some View {
        Toggle(isOn: $isOn) {
            "Toggle"
        }
//        .modifier(bor())
    }
}

struct Toggle_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Toggle_UI_Showcase()
    }
}
