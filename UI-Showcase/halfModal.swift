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

/// 决定用这个来模仿地图里面的那个 东西
/// 果然, 越花哨的东西, 写起来越麻烦😁
//struct halfModal: View {
//    var body: some View {
//        VStack {
//            sheetButton(destination: { halfModal() }) {
//                Text("hello world")
//            }.sheetButtonStyle(.button)
//        }
//    }
//}

struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        halfModal()
    }
}

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
                s = v.translation /// 用于正在拖动时的 移动

                if pillLocation == nil {
                    pillLocation = 0
                }

                /// predictedEndTranslation 更符合 用户的心理预期
                pillLocation! += v.predictedEndTranslation.height
            }

            .onChanged { (_: DragGesture.Value) in

//                print("[v.translation.height]:\t\(v.translation.height)") //

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
}

/// 存储 pill  的位置
private var pillLocation: CGFloat?

extension halfModalAndGesture {
    private var pill: some View {
        GeometryReader { g -> RoundedRectangle in

            let frame = g.frame(in: .global)
            let l = frame.origin.y
            pillLocation = l

            //            print(l)
            return RoundedRectangle(cornerRadius: 30)

        }.frame(width: 100.0, height: 8)
            .opacity(0.5)
            .padding(.vertical)
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
