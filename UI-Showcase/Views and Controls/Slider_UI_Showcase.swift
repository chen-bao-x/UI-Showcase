//
//  Slider_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Slider_UI_Showcase: View {
    @State private var value: Double = 0.5
    var body: some View {
        HStack {
            "Slider"

            "value:"

            "\(self.value)"
                .modifier(bor())

            Slider(value: $value)
        }
    }
}

struct Slider_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Slider_UI_Showcase()
    }
}
