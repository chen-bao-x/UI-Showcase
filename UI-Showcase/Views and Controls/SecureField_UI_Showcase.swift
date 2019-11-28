//
//  SecureField_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct SecureField_UI_Showcase: View {
    @State private var text: String = "text"
    var body: some View {
        HStack {
            "SecureField"
            SecureField("title", text: $text)
                .modifier(bor())
        }
    }
}

struct SecureField_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        SecureField_UI_Showcase()
    }
}
