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
//        ScrollView {
        VStack {
            Spacer()
            Text("hello 世界")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(Color.green)

//        }

        .navigationBarTitle(Text(""), displayMode: .inline)

        .modifier(halfModalAndGesture())
    }
}

/// 决定用这个来模仿地图里面的那个 东西
/// 果然, 越花哨的东西, 写起来越麻烦😁
struct halfModalAndGesture: ViewModifier {
    func body(content: Content) -> some View {
        let a = DragGesture()
            .updating(self.$gestureOffset) { v, s, _ in

                s = v.translation /// 用于正在拖动时的 移动
            }

            .onEnded { (v: DragGesture.Value) in

                if self.gestureOffset.height < v.predictedEndTranslation.height {
                    print("down")
                    self.currnetHalfState.halfOrTop.down()
                } else {
                    print("up")
                    self.currnetHalfState.halfOrTop.up()
                }

                self.touchBegingState.halfOrTop = self.currnetHalfState.halfOrTop
            }

        return GeometryReader { (g: GeometryProxy) in
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
            Animation.spring(response: 0.2, dampingFraction: 0.7, blendDuration: 1) : .none) /// 只在 拖动结束时的位置 归位 才 使用 动画

        .gesture(a)
    }

    @GestureState private var gestureOffset: CGSize = .zero

    @State private var storedGemotryReder_Size: CGSize = .zero

    private var currnetHalfState = stater()

    private var touchBegingState = stater()

    // MARK: - 当用户滑动时 halfModal 的 偏移量, 也就是上下移动

    var finalOffset: CGFloat {
        nonmutating get {
//            print("[gestureOffset.height]:\t\(gestureOffset.height)")
            if self.gestureOffset.height != 0 { /// 拖拽中
//                let a = f(self.storedGemotryReder_Size.height,
//                          h: self.touchBegingState.halfOrTop)
//                let height = a + self.gestureOffset.height
//
//                return height

                let a = f(self.storedGemotryReder_Size.height,
                          h: self.touchBegingState.halfOrTop)

                let height = a + self.gestureOffset.height

                if lastDragingLocating == 0 {
                    lastDragingLocating = a + self.gestureOffset.height
                }

                if let pill = pillLocation, pill < 00 {
                    let re = lastDragingLocating + ((height - lastDragingLocating) / 500)
                    lastDragingLocating = re

                    return re

                } else {
                    let re = lastDragingLocating + (height - lastDragingLocating)

                    lastDragingLocating = re

                    return re
                }

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

private var lastDragingLocating: CGFloat = 0

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

//            print("[pillLocation]:\t\(pillLocation)")
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

        mutating func up() {
            if self == .bottom {
                self = .half
            } else if self == .half {
                self = .top
            }
        }

        mutating func down() {
            if self == .top {
                self = .half
                return
            } else if self == .half {
                self = .bottom
                return
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

struct halfModal_top {
    var top: Anchor<CGPoint>?
}

struct MyTextPreferenceKey: PreferenceKey {
    typealias Value = [halfModal_top]

    static var defaultValue: [halfModal_top] = []

    static func reduce(value: inout [halfModal_top],
                       nextValue: () -> [halfModal_top]) {
        value.append(contentsOf: nextValue())
    }
}

// extension halfModalAndGesture {
//    private var g: DragGesture {
//        DragGesture()
//        .updating(self.$gestureOffset) { v, s, _ in
//
//            /// 滑到 顶部时, 就不需要在 滑动了
//
//            s = v.translation /// 用于正在拖动时的 移动
//        }
//
//        .onChanged { (v: DragGesture.Value) in
//            if pillLocation == nil {
//                pillLocation = 0
//            } else {
//                /// predictedEndTranslation 更符合 用户的心理预期
//                pillLocation! += v.predictedEndTranslation.height
//            }
//
//            let a = self.storedGemotryReder_Size.height / 3
//
//            if let location = pillLocation {
//                if location > (a * 2) {
//                    ///  bottom
//                    self.currnetHalfState.halfOrTop.toBottom()
//                } else if location > a, location < (a * 2) {
//                    ///  half
//                    self.currnetHalfState.halfOrTop.toHalf()
//                } else {
//                    ///  top
//                    self.currnetHalfState.halfOrTop.toTop()
//                }
//            }
//        }
//
//        .onEnded { (_: DragGesture.Value) in
//
//            self.touchBegingState.halfOrTop = self.currnetHalfState.halfOrTop
//
//
//        }
//    }
// }
