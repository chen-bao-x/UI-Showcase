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

                .modifier(frame_ViewModifer(framePropertys: self.$allProperty.framePropertys))
                .modifier(border_ViewModifer(border: $allProperty.boder))
        }
    }

    var Changer: some View {
        List {
            NavigationLink(destination:
                borderChanger(border: self.$allProperty.boder)) { "border" }
            NavigationLink(destination:
                frame_PropertyChanger(f: self.$allProperty.framePropertys)) {
                "frame"
            }
        }
    }

    @Environment(\.presentationMode) var isPresented: Binding<PresentationMode>
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
            .sheet(isPresented: $sheetIsPresented) {
                NavigationView {
                    self.content()
                        .navigationBarTitle(Text("Property Changer"))
                        .navigationBarItems(trailing: Button(action: { self.sheetIsPresented.toggle() }) { "完成" })
                }
            }
//            .popover(isPresented: $sheetIsPresented) { self.content() }
            .contextMenu {
                Button(action: {
                    self.sheetIsPresented.toggle()
                }) {
                    "edit view modifier"
                }
            }
    }

    @State private var sheetIsPresented: Bool = false
}
