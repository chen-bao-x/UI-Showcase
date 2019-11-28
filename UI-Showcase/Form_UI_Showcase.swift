//
//  Form_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Form_UI_Showcase: View {
    var body: some View {
        Form {
            Section(header: "header", footer: "footer") {
                ForEach(0...10, id: \.self) {
                    Text("cell \($0)")
                }
            }
        }
    }
}

struct Form_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Form_UI_Showcase()
    }
}
