//
//  halfModal.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/20.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import nav
import SwiftUI

struct halfModal: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("hello 世界")
            }.frame(height: 400)
        }
        .navigationBarTitle(Text(""), displayMode: .inline)

        .modifier(halfModalAndGesture())
    }
}

/// 决定用这个来模仿地图里面的那个 东西
/// 果然, 越花哨的东西, 写起来越麻烦😁
struct halfModalAndGesture: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { (g: GeometryProxy) in
            self.anthorGeter
            VStack {
                self.pill
                    .onAppear {
                        self.storedGemotryReder_Size = g.size
                    }

                Spacer()
            }
        }
        .overlay(
            content
                .offset(x: 0, y: 100)
                .disabled(self.currnetHalfState.halfOrTop == .top ? false : true)
        )

        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(RoundedCorners(color: .blue, tl: 20, tr: 20))

        .offset(y: self.finalOffset) /// 位置的 移动

        .animation(self.gestureOffset.height == 0 ?
            .spring(response: Double(0.3)) : .none) /// 只在 拖动结束时的位置 归位 才 使用 动画

        .gesture(DragGesture()
            .updating(self.$gestureOffset) { v, s, _ in

                /// 滑到 顶部时, 就不需要在 滑动了
                if let pill = pillLocation {
                    if pill > -100 {
                        s = v.translation /// 用于正在拖动时的 移动
                    }
                }

                if pillLocation == nil {
                    pillLocation = 0
                } else {
                    /// predictedEndTranslation 更符合 用户的心理预期
                    pillLocation! += v.predictedEndTranslation.height
                }
            }

            .onChanged { (_: DragGesture.Value) in

                let a = self.storedGemotryReder_Size.height / 3

                if let location = pillLocation {
                    if location > (a * 2) {
                        ///  bottom
                        self.currnetHalfState.halfOrTop.toBottom()
                    } else if location > a, location < (a * 2) {
                        ///  half
                        self.currnetHalfState.halfOrTop.toHalf()
                    } else {
                        ///  top
                        self.currnetHalfState.halfOrTop.toTop()
                    }
                }
            }

            .onEnded { (_: DragGesture.Value) in

                self.touchBegingState.halfOrTop = self.currnetHalfState.halfOrTop
            }
        )
    }

    @GestureState private var gestureOffset: CGSize = .zero

    @State private var storedGemotryReder_Size: CGSize = .zero

    private var currnetHalfState = stater()

    private var touchBegingState = stater()

    /// 当用户滑动时 halfModal 的 偏移量
    var finalOffset: CGFloat {
        nonmutating get {
            if self.gestureOffset.height != 0 { /// 拖拽中
                let a = f(self.storedGemotryReder_Size.height,
                          h: self.touchBegingState.halfOrTop)

                let height = a + self.gestureOffset.height

                return height

            } else {
                return f(self.storedGemotryReder_Size.height, h: self.currnetHalfState.halfOrTop)
            }
        }
    }

    private func f(_ c: CGFloat, h: HalfOrTop) -> CGFloat {
        switch h {
        case .top: return 0

        case .half: return c / 2

        case .bottom: return c - 100
        }
    }
}

/// 存储 pill  的位置
private var pillLocation: CGFloat?

extension halfModalAndGesture {
    private var pill: some View {
        HStack {
            Spacer()

            LineView(fatherViewHeight: self.storedGemotryReder_Size.height)
                .frame(width: 100, height: 20)
                .padding()

            Spacer()
        }
    }

    private var anthorGeter: some View {
        GeometryReader { g -> Color in

            let frame = g.frame(in: .global)
            let l = frame.origin.y
            pillLocation = l

//            print(l)
            return Color.clear
        }
    }
}

extension halfModalAndGesture {
    private class stater {
        var isFirst = true

        var halfOrTop: HalfOrTop = .half
    }

    private enum HalfOrTop {
        case top
        case half
        case bottom

        mutating func toHalf() {
            if self != .half {
                self = .half
            }
        }

        mutating func toTop() {
            if self != .top {
                self = .top
            }
        }

        mutating func toBottom() {
            if self != .bottom {
                self = .bottom
            }
        }
    }
}

/// code form here : https://swiftui-lab.com/geometryreader-to-the-rescue/
struct RoundedCorners: View {
    var color: Color = .black
    var tl: CGFloat = 0.0
    var tr: CGFloat = 0.0
    var bl: CGFloat = 0.0
    var br: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            Path { path in

                let w = geometry.size.width
                let h = geometry.size.height

                // We make sure the redius does not exceed the bounds dimensions
                let tr = min(min(self.tr, h / 2), w / 2)
                let tl = min(min(self.tl, h / 2), w / 2)
                let bl = min(min(self.bl, h / 2), w / 2)
                let br = min(min(self.br, h / 2), w / 2)

                path.move(to: CGPoint(x: w / 2.0, y: 0))
                path.addLine(to: CGPoint(x: w - tr, y: 0))
                path.addArc(center: CGPoint(x: w - tr, y: tr), radius: tr, startAngle: Angle(degrees: -90), endAngle: Angle(degrees: 0), clockwise: false)
                path.addLine(to: CGPoint(x: w, y: h - br))
                path.addArc(center: CGPoint(x: w - br, y: h - br), radius: br, startAngle: Angle(degrees: 0), endAngle: Angle(degrees: 90), clockwise: false)
                path.addLine(to: CGPoint(x: bl, y: h))
                path.addArc(center: CGPoint(x: bl, y: h - bl), radius: bl, startAngle: Angle(degrees: 90), endAngle: Angle(degrees: 180), clockwise: false)
                path.addLine(to: CGPoint(x: 0, y: tl))
                path.addArc(center: CGPoint(x: tl, y: tl), radius: tl, startAngle: Angle(degrees: 180), endAngle: Angle(degrees: 270), clockwise: false)
            }
            .fill(self.color)
        }
    }
}
