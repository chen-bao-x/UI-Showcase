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
                
                .modifier(frame_ViewModifer(framePropertys: self.$allProperty.framePropertys))
                .modifier(border_ViewModifer(border: $allProperty.boder))
                
                .modifier(contextToPopover(被弹出: { self.Changer }))
        }
    }
    
    var Changer: some View {
//        NavigationView {
        List {
            可折叠Section(headerTitle: Text("border")) {
                borderChanger(border: self.$allProperty.boder)
            }
            
            可折叠Section(headerTitle: Text("Frame Changer")) {
                frame_PropertyChanger(f: self.$allProperty.framePropertys)
            }
            
//                NavigationLink(destination:
//                    borderChanger(border: self.$allProperty.boder)
//
//                ) { "border" }
//                NavigationLink(destination:
//                    frame_PropertyChanger(f: self.$allProperty.framePropertys)) {
//                    "frame"
//                }
        }
//        }.navigationBarTitle(Text(""), displayMode: .inline)
//            .navigationBarHidden(true)
    }
    
    @Environment(\.presentationMode) var isPresented: Binding<PresentationMode>
}

struct contextToPopover<Content: View>: ViewModifier {
    init(onDismiss: @escaping () -> () = {}, @ViewBuilder 被弹出: @escaping () -> Content) {
        self.onDismiss = onDismiss
        
        self.content = 被弹出
    }
    
    let content: () -> Content
    
    let onDismiss: () -> ()
    
    func body(content: _ViewModifier_Content<contextToPopover>) -> some View {
        ZStack {
            content
                .contextMenu {
                    Button(action: {
                        self.sheetIsPresented.toggle()
                    }) {
                        "edit view modifier"
                    }
                }
            
            if self.sheetIsPresented {
                GeometryReader { _ in
                    
                    缩放按钮(back: { self.sheetIsPresented.toggle() }) {
                        self.content()
                    }
//                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                .modifier(halfModalAndGesture())
            }
        }
        .onDisappear {
            self.onDismiss()
        }
    }
    
    struct 缩放按钮<Content: View>: View {
        init(back: @escaping () -> (), content: @escaping () -> Content) {
            self.content = content
            
            self.back = back
        }
        
        let content: () -> Content
        let back: () -> ()
        @State private var tog: Bool = false
        
        var body: some View {
            ZStack {
                VStack {
                    HStack {
                        Button(action: { self.back() }) {
                            Image(systemName: "xmark.circle")
                                .font(.largeTitle)
                                .padding()
                        }
                        
                        Spacer()
                        "Scale".onTapGesture { withAnimation { self.tog.toggle() } }
                    }
                    .background(Color.white.opacity(0.5))
                    
                    
                    self.content()
//                        .gesture(DragGesture())
                }
                .foregroundColor(self.tog ? .clear : .none)
                if self.tog {
                    RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.green)
                        .frame(width: 40, height: 40)
                        .onTapGesture { withAnimation { self.tog.toggle() } }
                }
            }
            .frame(width: tog ? 40 : nil, height: tog ? 40 : nil)
            .transition(AnyTransition.scale)
        }
    }
    
    @State private var sheetIsPresented: Bool = false
}

// struct contextToPopover<Content: View>: ViewModifier {
//    init(onDismiss: @escaping () -> () = {}, @ViewBuilder 被弹出: @escaping () -> Content) {
//        self.onDismiss = onDismiss
//
//        self.content = 被弹出
//    }
//
//    var content: () -> Content
//
//    var onDismiss: () -> ()
//
//    func body(content: _ViewModifier_Content<contextToPopover>) -> some View {
//        content
//            .sheet(isPresented: $sheetIsPresented) {
//                NavigationView {
//                    self.content()
//                        .navigationBarTitle(Text("Property Changer"))
//                        .navigationBarItems(trailing: Button(action: { self.sheetIsPresented.toggle() }) { "完成" })
//                }
//            }
////            .popover(isPresented: $sheetIsPresented) { self.content() }
//            .contextMenu {
//                Button(action: {
//                    self.sheetIsPresented.toggle()
//                }) {
//                    "edit view modifier"
//                }
//            }
//    }
//
//    @State private var sheetIsPresented: Bool = false
// }
