//
//  Stepper_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Stepper_UI_Showcase: View {
    @State private var value: Int = 0
    var body: some View {
        Stepper(value: $value, in: 0...1000) {
            HStack {
                "Stepper"

                "vaulue:"
                "\(self.value)"
                    .modifier(bor())
            }
        }
    }
}

struct Stepper_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Stepper_UI_Showcase()
    }
}
