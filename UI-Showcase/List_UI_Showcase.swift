//
//  List_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct List_UI_Showcase: View {
    var body: some View {
        List {
            ForEach(0...9, id: \.self) {
                "list cell  \($0)"
            }
            
            Section(header: Text("header"), footer: Text("footer")) {
                ForEach(0...9, id: \.self) {
                    "list cell  \($0)"
                }
            }
            
            Section(header: Text("header"), footer: Text("footer")) {
                ForEach(0...9, id: \.self) {
                    "list cell  \($0)"
                        .listRowBackground(self.colors[$0])
                }
            }
            
            Section(header: Text("header"), footer: Text("footer")) {
                ForEach(0...9, id: \.self) {
                    Text("list cell  \($0)")
                        .padding(CGFloat($0 * 10))
                }
            }
        }
    }
    
    var colors: [Color] = [
        .red,
        .green,
        .gray,
        .black,
        .orange,
        .pink,
        .purple,
        .primary,
        .secondary,
        .yellow,
        .accentColor
    ]
}

struct List_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        List_UI_Showcase()
    }
}
