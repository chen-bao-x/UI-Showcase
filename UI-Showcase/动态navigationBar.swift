//
//  动态navigationBar.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/7.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import SwiftUI

var counter: Int = 0

let ScreenWidth = UIScreen.main.bounds.size.width
struct 动态navigationBar: View {
    @State private var b: Bool = false

    @State private var point: CGFloat = 0

    @ObservedObject var pp = 当前位置()

    var body: some View {
        ZStack(alignment: .top) {
            self.顶部横条.zIndex(100)

            ScrollView {
                VStack {
//                    self.锚点

                    HStack {
                        VStack {
                            Image("p15")
                                .resizable()
                                .frame(width: 200, height: 100)
                            Text("navigationBar")
                                .font(.largeTitle)
                        }
                        Spacer()
                    }

                    Text("\(self.point)")
                    Text(longText)
//                    .font(self.b ? .largeTitle : .body)
                        .frame(width: 400, height: 1000) // 固定尺寸, 刷新的时候就不用 争个 body 遍历 了.

                }.offset(CGSize(width: 0, height: 120))
            }
        }
        .navigationBarTitle(Text(""), displayMode: .inline)
        .edgesIgnoringSafeArea(.all)
        .navigationBarHidden(true)
        .navigationBarBackButtonHidden(false)
    }

    var 锚点: some View {
        GeometryReader { g -> Color in

            let frame = g.frame(in: CoordinateSpace.global)

            if frame.origin.y > 0 {
                if frame.origin.y < 120 {
                    self.pp.pub.send(frame.origin.y)
                }
            }

            return Color.clear
        }
    }

    @State private var off: CGFloat = 120

    var 顶部横条: some View {
        HStack(alignment: .bottom) {
            Text("navigationBar")
                .frame(width: ScreenWidth, height: 100)

//                .offset(CGSize(width: 0, height: self.pp.off))
//                .opacity(Double(self.pp.off / -120))
        }
        .frame(height: self.pp.off)

        .background(Color.blue)
    }
}

struct __navigationBar_Previews: PreviewProvider {
    static var previews: some View {
        动态navigationBar()
    }
}

var longText: String = { () -> String in

    (0...100)
        .map { "[ \($0) ]: hellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohellohello" }
        .joined(separator: "")

}()

class 当前位置: ObservableObject {
    init() {
        self.cancel = self.pub
            .print()
            .debounce(for: 0.001, scheduler: DispatchQueue.main)
            .sink { self.off = $0 }
    }

    @Published var off: CGFloat = 1

    var pub = PassthroughSubject<CGFloat, Never>()
    var cancel: AnyCancellable = AnyCancellable {}
}

struct haha锚点: View {
    var body: some View {
        GeometryReader { (g) -> Color in

            let frame = g.frame(in: CoordinateSpace.global)

            if frame.origin.y > 0 {
                if frame.origin.y < 120 {
//                    self.pp.pub.send(frame.origin.y)
                    counter += 1
                    print(counter)
                }
            }

            return Color.clear
        }
    }
}
