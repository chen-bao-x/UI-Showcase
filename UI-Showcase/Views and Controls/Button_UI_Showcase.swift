//
//  Button_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Button_UI_Showcase: View {
    @State private var who: Bool = false
    var body: some View {
        HStack {
            Button_UI_Showcase_segment(who: $who)
            Button(action: { self.who.toggle() }) {
                "Button"
                    .modifier(bor())
            }
        }
    }
}

struct Button_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Button_UI_Showcase()
    }
}

struct Button_UI_Showcase_segment: View {
    @Binding var who: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Hello, World!")
                    .background(who ? Color.green : Color.clear)
                    .onTapGesture {
                        self.who = true
                    }

                Text("Hello, World!")
                    .background(who ? Color.clear : Color.green)
                    .onTapGesture {
                        self.who = false
                    }
            }
            .frame(height: 80)
            .background(
                VStack {
                    Spacer()

                    Color.red.frame(width: UIScreen.main.bounds.width,
                                    height: 10)
                        .offset(CGSize(width: UIScreen.main.bounds.width / (self.who ? 2 : -2), height: 0))
                }
            )
        }
        .animation(.default)
        .transition(.slide)
        .clipped()
    }
}
