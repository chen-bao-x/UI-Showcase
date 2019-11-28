//
//  PropertyChanger.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import nav
import SwiftUI

struct PropertyChanger: ViewModifier {
    @ObservedObject var allProperty: AllPropertys = AllPropertys()

    func body(content: _ViewModifier_Content<PropertyChanger>) -> some View {
        ZStack {
            content
                .modifier(contextToPopover(被弹出: { self.Changer }))
//                .modifier(modifers(allProperty: self.allProperty))

                .modifier(frame_ViewModifer(framePropertys: self.$allProperty.framePropertys))
                .modifier(border_ViewModifer(border: $allProperty.boder))
        }
    }

    var Changer: some View {
        NavigationView {
            List {
                NavigationLink(destination:
                borderChanger(border: self.$allProperty.boder)) { "border" }
                NavigationLink(destination:
                    frame_PropertyChanger(f: self.$allProperty.framePropertys)) {
                    "frame"
                }
            }
            .navigationBarTitle(Text("Property Changer"))
        }
    }

//    struct modifers: ViewModifier {
//        @Binding var allProperty: AllPropertys
//        func body(content: _ViewModifier_Content<PropertyChanger.modifers>) -> some View {
//            content
//                .modifier(frame_ViewModifer(framePropertys: self.$allProperty.framePropertys))
//                .modifier(border_ViewModifer(WhetherShow: $allProperty.WhetherShowBoder))
//        }
//    }
}

struct contextToPopover<Content: View>: ViewModifier {
    init(onDismiss: @escaping () -> () = {}, @ViewBuilder 被弹出: @escaping () -> Content) {
        self.onDismiss = onDismiss

        self.content = 被弹出
    }

    var content: () -> Content

    var onDismiss: () -> ()

    func body(content: _ViewModifier_Content<contextToPopover>) -> some View {
        content
            .popover(isPresented: $sheetIsPresented) { self.content() }
            .contextMenu {
                Button(action: {
                    self.sheetIsPresented.toggle()
                }) {
                    "edit view modifier"
                }
            }

//            .sheet(isPresented: $sheetIsPresented, onDismiss: onDismiss) { self.content() }
//            .onLongPressGesture { self.sheetIsPresented.toggle() }
    }

    @State private var sheetIsPresented: Bool = false
}
