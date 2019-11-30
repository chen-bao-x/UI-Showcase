//
//  frame_ViewModifer.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct frame_ViewModifer: ViewModifier {
    @Binding var framePropertys: AllPropertys.frame
    func body(content: _ViewModifier_Content<frame_ViewModifer>) -> some View {
        content
            .frame(width: framePropertys.setFrame ? framePropertys.Width : nil,
                   height: framePropertys.setFrame ? framePropertys.Height : nil,
                   alignment: framePropertys.alignment)
    }
}

struct frame_PropertyChanger: View {
    @Binding var f: AllPropertys.frame

    var body: some View {
        List {
            VStack(alignment: .leading) {
                "设置 frame 前, 先显示 border 可以更直观的看到变化"
                Toggle(isOn: self.$f.setFrame) { Text("设置 frame") }
            }

            if self.f.setFrame {
                VStack(alignment: .leading) { "width:\(f.Width)"; Slider(value: $f.Width, in: 0...2000) }

                VStack(alignment: .leading) { "height:\(f.Height)"; Slider(value: $f.Height, in: 0...2000) }

                VStack(alignment: .leading) {
                    "Alignment"
                    Picker(selection: self.$f.selection, label: Text("")) {
                        Text("leading").tag(0)
                        Text("trailing").tag(1)
                        Text("top").tag(2)
                        Text("topLeading").tag(3)
                        Text("topTrailing").tag(4)
                        Text("center").tag(5)
                        Text("bottom").tag(6)
                        Text("bottomLeading").tag(7)
                        Text("bottomTrailing").tag(8)
                    }
                }
            }
        }
        .navigationBarTitle(Text("Frame Changer"))
    }
}
