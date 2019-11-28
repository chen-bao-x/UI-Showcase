//
//  coloringText.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/7.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct coloringText: View {
    init() {
        UINavigationBar.appearance().backgroundColor = .clear
    }

    var body: some View {
        VStack {
            Text("hello")
            LinearGradient(gradient: Gradient(colors: [Color(red: r, green: g, blue: b),
                                                       Color(red: b, green: g, blue: b),
                                                       Color(red: r, green: g, blue: b),
                                                       Color(red: r, green: r, blue: b),
                                                       Color(red: r, green: g, blue: b),
                                                       Color(red: r, green: g, blue: r),
                                                       Color(red: g, green: g, blue: b)]),
                           startPoint: .leading, endPoint: .trailing)
                .mask(self.a)
                .animation(.default)

        }.onAppear {
            DispatchQueue.main.async {
                Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
                    withAnimation {
                        self.r = randomIn(min: 0, max: 1)
                        self.g = randomIn(min: 0, max: 1)
                        self.b = randomIn(min: 0, max: 1)
                    }
                }
            }
        }

//        .truncationMode(.head) //  为太长而无法容纳可用空间的文本行设置截断模式。
    }

    @State private var c: Color = .init(red: randomIn(min: 0, max: 1),
                                        green: randomIn(min: 0, max: 1),
                                        blue: randomIn(min: 0, max: 1))

    @State private var r: Double = randomIn(min: 0, max: 1)
    @State private var g: Double = randomIn(min: 0, max: 1)
    @State private var b: Double = randomIn(min: 0, max: 1)

    var a: some View {
        Text(longText)
    }
}

func randomIn(min: Int, max: Int) -> Double {
    let a = Int(arc4random()) % (max - min + 1) + min

    return Double(a)
}

struct coloringText_Previews: PreviewProvider {
    static var previews: some View {
        coloringText()
    }
}

extension Text: Shape {
    public func path(in rect: CGRect) -> Path {
        Path { p in
            p.addLines([CGPoint(x: 10, y: 10),
                        CGPoint(x: 110, y: 110),
                        CGPoint(x: 110, y: 110),
                        CGPoint(x: -10, y: -10),
                        CGPoint(x: -110, y: -110)])
        }
    }
}
