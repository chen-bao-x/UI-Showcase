//
//  PulltoRefresh.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/19.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct PulltoRefresh: View {
    @State var y = CGFloat(0)
    @State var b = false
    @State var d = Double(0)
    @State var imageName = "arrow.up"

    @State var off: CGFloat = 0
    let o = O()
    var body: some View {
        ZStack(alignment: .top) {
            ScrollView {
                img
                VStack {
                    if self.b == false {
                        Image(systemName: self.imageName)
                            .rotationEffect(Angle(degrees: 180))
                            .font(.largeTitle)
                        //                            .animation(Animation.default, value: self.d)
                    } else {
                        Image(systemName: "arrow.2.circlepath").font(.largeTitle)
                            .rotationEffect(Angle(degrees: self.d), anchor: .center)
                            .animation(Animation.default.repeatForever(autoreverses: false), value: self.d)
                            .onAppear {
                                self.d = self.d == 0 ? 180 : 0
                            }
                    }
                    "some text"
                }.offset(x: 0, y: self.off)

            }.edgesIgnoringSafeArea(.top)
        }
    }

    var img: some View {
        VStack {
            GeometryReader { g -> EmptyView in
                let frame = g.frame(in: CoordinateSpace.global)

                if frame.origin.y > 130 {
                    self.b = true
                    self.off = 100
                } else {
                    DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
                        if frame.origin.y < 50 {
                            self.b = false
                            self.d = 0
                            withAnimation { self.off = 0 }
                        }
                    }
                }

                return EmptyView()
            }
        }
    }
}

struct O: View {
    @State var d = Double(0)
    var body: some View {
        Image(systemName: "arrow.2.circlepath")
            .rotationEffect(Angle(degrees: self.d), anchor: .center)
            .animation(Animation.default.repeatForever(autoreverses: false), value: self.d)
            .onAppear { self.d = 180 }
            .frame(width: 40, height: 40)
    }
}

struct PulltoRefresh_Previews: PreviewProvider {
    static var previews: some View {
        PulltoRefresh()
    }
}

struct anthor: View {
    @Binding var b: Bool

    var point: CGFloat = 0
    var body: some View {
        VStack {
            GeometryReader { g -> EmptyView in
                let frame = g.frame(in: CoordinateSpace.global)

                if frame.origin.y > self.point {
                    self.b = true

                } else {
                    if frame.origin.y < self.point {
                        self.b = false
                    }
                }
                return EmptyView()
            }
        }
    }
}
