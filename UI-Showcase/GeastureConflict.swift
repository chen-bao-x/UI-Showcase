//
//  GeastureConflict.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/25.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

/// 尽管可以用 overlay 来解决, 但是太不方便, 太不优雅了......
struct GeastureConflict: View {
    @State private var hehe: Float = 4

    @State private var who: String = ""
    var body: some View {
        VStack {
            Text("\(who)")

            Text("\(hehe)")
                .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 400, alignment: .bottom)
                .padding(.bottom)
        }

        .gesture(DragGesture().onChanged { _ in
            if self.who != "VStack draging" {
                self.who = "VStack draging"
            }
        })

        .overlay(
            Slider(value: $hehe, in: 0...30)
        )
    }
}

struct GeastureConflict_Previews: PreviewProvider {
    static var previews: some View {
        GeastureConflict()
    }
}
