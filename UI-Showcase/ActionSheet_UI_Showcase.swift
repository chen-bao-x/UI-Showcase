//
//  ActionSheet_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct ActionSheet_UI_Showcase: View {
    @State private var isPresented: Bool = false
    var body: some View {
        Button(action: {self.isPresented.toggle()}) {
            Text("Hello, World!")
                .actionSheet(isPresented: $isPresented) { () -> ActionSheet in
                    ActionSheet(title: Text("Text"), message: Text("message"), buttons: [
                        .default(Text("text")),

                        .cancel()
                    ])
                }
        }
    }
}

struct ActionSheet_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        ActionSheet_UI_Showcase()
    }
}
