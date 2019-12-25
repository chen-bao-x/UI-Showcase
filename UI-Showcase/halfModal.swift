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

/// 尽管已经做的不错了, 但是还是不够好. 参考 Twitter 的 halfModal, Twitter 的那个是 系统自带的.
/// 做不到像 .sheet 那样的吧其他的视图都放到 halfModal 的后面
/// `放弃`
struct halfModal: View {
    var body: some View {
        ZStack {
            sheetButton(destination: { modal() }) {
                Text("hello world")
            }.sheetButtonStyle(.button)
            modal()
        }.edgesIgnoringSafeArea(.bottom)

            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity)
    }
}

struct searchBar_Previews: PreviewProvider {
    static var previews: some View {
        halfModal()
    }
}

struct modal: View {
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 30)
                .frame(width: 100.0, height: 8)
                .opacity(0.5)
                .padding(.vertical)

            VStack {
                Text("hello 世界")
                Spacer()
            }
            .frame(minWidth: 0, maxWidth: .infinity,
                   minHeight: 0, maxHeight: .infinity)
        }
        .edgesIgnoringSafeArea(.bottom)
        .frame(minWidth: 0, maxWidth: .infinity,
               minHeight: 0, maxHeight: .infinity)

        .background(Color.blue)
        .navigationBarTitle(Text(""), displayMode: .inline)
        .modifier(halfModalAndGesture())
    }
}

struct halfModalAndGesture: ViewModifier {
    func body(content: Content) -> some View {
        GeometryReader { (g: GeometryProxy) in

            content.onAppear() {
                self.soredGemotryRederSize = g.size
            }
        }
//        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)
        .frame(width: UIScreen.main.bounds.width,
               height: UIScreen.main.bounds.height)

        .offset(y: self.finalOffset)

        .animation(self.gestureOffset.height == 0 ? Animation.spring(response: Double(0.3)) : .none)

        .gesture(DragGesture()
            .updating(self.$gestureOffset) { v, s, _ in

                s = v.translation
            }

            .onChanged { (v: DragGesture.Value) in

                if v.translation.height < 0 { /// 往上滑动
                    self.halfOrTop.halfOrTop.toTop()

                } else { /// 往下滑动
                    self.halfOrTop.halfOrTop.toHalf()
                }
            }

            .onEnded { (_: DragGesture.Value) in

                self.touchBegingState.halfOrTop = self.halfOrTop.halfOrTop
            }
        )
    }

    @GestureState private var gestureOffset: CGSize = .zero
    var finalOffset: CGFloat {
        if self.gestureOffset.height != 0 { /// 拖拽中
            let a = f(self.soredGemotryRederSize.height,
                      h: self.touchBegingState.halfOrTop)

            let height = a + self.gestureOffset.height

            return height

        } else {
            return f(self.soredGemotryRederSize.height, h: self.halfOrTop.halfOrTop)
        }
    }

    @State private var soredGemotryRederSize: CGSize = .zero

    private var halfOrTop = sdafadsfasdfdasfasfsdf()

    private var touchBegingState = sdafadsfasdfdasfasfsdf()

    private class sdafadsfasdfdasfasfsdf {
        var isFirst = true

        var halfOrTop: HalfOrTop = .half
    }

    private enum HalfOrTop {
        case half
        case top

        mutating func toggle() {
            if self == .half {
                self = .top
            } else {
                self = .half
            }
        }

        mutating func toHalf() {
            if self == .top {
                self = .half
            }
        }

        mutating func toTop() {
            if self == .half {
                self = .top
            }
        }
    }

    private func f(_ c: CGFloat, h: HalfOrTop) -> CGFloat {
        switch h {
        case .half: return c / 2

        case .top: return 0
        }
    }
}
