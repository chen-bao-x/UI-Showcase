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

struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        halfModal()
    }
}

/// 决定用这个来模仿地图里面的那个 东西
/// 果然, 越花哨的东西, 写起来越麻烦😁
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

        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
        .background(Color.blue)
        .overlay(
            content
                .offset(x: 0, y: 100)
        )
        .offset(y: self.finalOffset)

        .animation(self.gestureOffset.height == 0 ? Animation.spring(response: Double(0.3)) : .none)

        .gesture(DragGesture()
            .updating(self.$gestureOffset) { v, s, _ in

                /// 滑到 顶部时, 就不需要在 滑动了
                if let pill = pillLocation {
                    if pill > 0 {
                        s = v.translation /// 用于正在拖动时的 移动
                    }
                }

                if pillLocation == nil {
                    pillLocation = 0
                }

                /// predictedEndTranslation 更符合 用户的心理预期
                pillLocation! += v.predictedEndTranslation.height

//                if let location = pillLocation {
//                    self.fatherViewHeight = 1 - (location / self.storedGemotryReder_Size.height)
//                }
            }

            .onChanged { (_: DragGesture.Value) in

                let a = self.storedGemotryReder_Size.height / 3

                if let location = pillLocation {
                    if location > (a * 2) {
                        ///  bottom
                        self.halfState.halfOrTop.toBottom()
                    } else if location > a, location < (a * 2) {
                        ///  half
                        self.halfState.halfOrTop.toHalf()
                    } else {
                        ///  top
                        self.halfState.halfOrTop.toTop()
                    }
                }
            }

            .onEnded { (_: DragGesture.Value) in
                self.touchBegingState.halfOrTop = self.halfState.halfOrTop
            }
        )
    }

    @GestureState private var gestureOffset: CGSize = .zero

    /// 当用户停止滑动时 halfModal 的 偏移量
    /// 根据
    var finalOffset: CGFloat {
        nonmutating get {
            if self.gestureOffset.height != 0 { /// 拖拽中
                let a = f(self.storedGemotryReder_Size.height,
                          h: self.touchBegingState.halfOrTop)

                let height = a + self.gestureOffset.height

                return height

            } else {
                return f(self.storedGemotryReder_Size.height, h: self.halfState.halfOrTop)
            }
        }
    }

    @State private var storedGemotryReder_Size: CGSize = .zero

    private var halfState = sdafadsfasdfdasfasfsdf()

    private var touchBegingState = sdafadsfasdfdasfasfsdf()

    private func f(_ c: CGFloat, h: HalfOrTop) -> CGFloat {
        switch h {
        case .top: return 0

        case .half: return c / 2

        case .bottom: return c - 100
        }
    }

//    @State private var midlePointHeight: CGFloat = 0
    private var midlePointHeight: CGFloat {
        if let location = pillLocation {
            return 1 - (location / self.storedGemotryReder_Size.height)
        }

        return 0
    }
}

/// 存储 pill  的位置
private var pillLocation: CGFloat?

extension halfModalAndGesture {
    private var pill: some View {
        HStack {
            Spacer()

//            LineView(fatherViewHeight: self.$fatherViewHeight)
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

            print(l)
            return Color.clear
        }
    }
}

extension halfModalAndGesture {
    private class sdafadsfasdfdasfasfsdf {
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


extension UIBezierPath {
    static func bezierPath(
        controlPoint1X: Double = 0.680,
        controlPoint1Y: Double = -0.550,
        controlPoint2X: Double = 0.265,
        controlPoint2Y: Double = 1.550
    ) -> UIBezierPath {
        
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addCurve(to: CGPoint(x: 1.0, y: -1.0), controlPoint1: CGPoint(x: controlPoint1X, y: -controlPoint1Y), controlPoint2: CGPoint(x: controlPoint2X, y: -controlPoint2Y))
        return path
    }
}
