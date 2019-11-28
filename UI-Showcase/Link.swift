////
////  Link.swift
////  UI-Showcase
////
////  Created by 陈宝 on 2019/11/26.
////  Copyright © 2019 chenbao. All rights reserved.
////
//
//import SwiftUI
//struct Linked: View {
//    var body: some View {
//        Link(destenation: Text("被弹出")) {
//            Text("Tap")
//
//        }
//    }
//}
//
//struct Link_Previews: PreviewProvider {
//    static var previews: some View {
//        Linked()
//    }
//}
//
//struct Link<Destination: View, Content: View>: View {
//    init(destenation: Destination, @ViewBuilder content: @escaping () -> Content) {
//        self.content = content
//        self.destination = destenation
//    }
//
//    let content: () -> Content
//    let destination: Destination
//    var body: some View {
//        NavigationView {
//            NavigationLink(destination: asdf { self.destination }) {
//                VStack {
//                    Text("Tap")
//                }
//            }
//            .navigationBarTitle(Text("navigationBarTitle"), displayMode: .inline)
//            .navigationBarHidden(true)
//        }.navigationViewStyle(StackNavigationViewStyle())
//    }
//
//    struct asdf<Destination: View>: View {
//        init(@ViewBuilder destination: @escaping () -> Destination) {
//            self.destination = destination
//        }
//
//        @Environment(\.presentationMode) private var isPrexented: Binding<PresentationMode>
//
//        let destination: () -> Destination
//
//        var body: some View {
//            ZStack(alignment: .topLeading) {
//                VStack {
//                    HStack {
//                        Button(action: { self.isPrexented.wrappedValue.dismiss() }) {
//                            Text("back")
//                        }
//                        Spacer()
//                    }
//
//                    self.destination()
//                }
//            }
//        }
//    }
//}
