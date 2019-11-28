//
//  TextField_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct TextField_UI_Showcase: View {
    @State private var text: String = "text"
    var body: some View {
        HStack {
            "TextField"

            TextField("title", text: $text)
                .modifier(bor())
        }
    }
}

struct UI_Showcase_TextField_Previews: PreviewProvider {
    static var previews: some View {
        TextField_UI_Showcase()
    }
}
