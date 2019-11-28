//
//  frame_ViewModifer.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct frame_ViewModifer: ViewModifier {
    @Binding var framePropertys: AllPropertys.FramePropertys
    func body(content: _ViewModifier_Content<frame_ViewModifer>) -> some View {
        content
            .frame(width: framePropertys.Width, height: framePropertys.Height,
                   alignment: framePropertys.alignment)
    }
}

struct frame_PropertyChanger: View {
    @Binding var f: AllPropertys.FramePropertys

    var body: some View {
        List {
            Button(action: { self.isPresented.wrappedValue.dismiss() }) { "back" }

            VStack { "minWidth:\(f.Width)"; Slider(value: $f.Width, in: 0...2000) }

            VStack { "maxHeight:\(f.Height)"; Slider(value: $f.Height, in: 0...2000) }

            Picker(selection: self.$f.selections, label: Text("alignment")) {
                Text("leading").tag(0)
                Text("trailing").tag(1)
                Text("top").tag(2)
                Text("topLeading").tag(3)
                Text("topTrailing").tag(4)
                Text("bottom").tag(5)
                Text("bottomLeading").tag(6)
                Text("bottomTrailing").tag(7)
            }
        }
        .navigationBarTitle(Text("Frame Changer"))
    }

    @Environment(\.presentationMode) private var isPresented: Binding<PresentationMode>
}


