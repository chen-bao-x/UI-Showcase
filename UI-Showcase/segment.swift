//
//  segment.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/26.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct segment: View {
    @State var who: Bool = false

    var body: some View {
        VStack {
            HStack {
                Text("Hello, World!")
                    .background(who ? Color.green : Color.clear)
                    .onTapGesture {
                        self.who.toggle()
                    }

                Text("Hello, World!")
                    .background(who ? Color.clear : Color.green)
                    .onTapGesture {
                        self.who.toggle()
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
//        .frame(width: 300)
        .clipped()
    }
}

struct segment_Previews: PreviewProvider {
    static var previews: some View {
        segment()
    }
}
