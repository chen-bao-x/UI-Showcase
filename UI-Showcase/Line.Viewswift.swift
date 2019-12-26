//
//  Line.Viewswift.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/26.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct LineView: View {
    var fatherViewHeight: CGFloat

    var body: some View {
        GeometryReader { (proxy: GeometryProxy) in

            self.useProxy(proxy, midlePointHeight:

                1 - proxy.frame(in: .global).origin.y /
                    self.fatherViewHeight)
        }
    }

    func useProxy(_ proxy: GeometryProxy, midlePointHeight: CGFloat) -> some View {
        let width = proxy.size.width
        let halfHeight = proxy.size.height / 2
        let middlePoint = CGPoint(x: width / 2.0, y: proxy.size.height * midlePointHeight)

        return Group {
            Path { path in
                path.addLines([
                    CGPoint(x: 0, y: halfHeight),
                    middlePoint,
                    CGPoint(x: width, y: halfHeight),
                ])
            }
            .strokedPath(StrokeStyle(lineWidth: halfHeight / 2,
                                     lineCap: .round,
                                     lineJoin: .round,
                                     miterLimit: 10,
                                     dash: [],
                                     dashPhase: 0)
            )
        }
    }
}

// struct MatrixView: View {
//    /// https://stackoverflow.com/questions/57065925/how-to-define-variables-inside-a-geometryreader-in-swiftui
//    var body: some View {
//        GeometryReader { proxy in
//            self.useProxy(proxy)
//        }
//    }
//
//    func useProxy(_ proxy: GeometryProxy) -> some View {
//        let width = proxy.size.width
//        let gradient = RadialGradient(gradient: Gradient(colors: [.gray, Color.gray.opacity(0.0)]), center: .center, startRadius: width * sqrt(2) * 0.5, endRadius: width * 1.05 * sqrt(2) * 0.5) // https://www.hackingwithswift.com/quick-start/swiftui/how-to-render-a-gradient
//        return Group {
//            Path { path in
//                path.addLines([
//                    CGPoint(x: 0, y: -width * 0.05),
//                    CGPoint(x: 0, y: width * 1.05),
//                ])
//                path.addLines([
//                    CGPoint(x: -width * 0.05, y: 0),
//                    CGPoint(x: width * 1.05, y: 0),
//                ])
//                path.addLines([
//                    CGPoint(x: -width * 0.05, y: width),
//                    CGPoint(x: width * 1.05, y: width),
//                ])
//                path.addLines([
//                    CGPoint(x: width, y: -width * 0.05),
//                    CGPoint(x: width, y: width * 1.05),
//                ])
//            }
//            .stroke(gradient)
//
//            ForEach(1 ..< 10) { i in
//                Path { path in
//                    path.addLines([
//                        CGPoint(x: width / 10 * CGFloat(i), y: 0),
//                        CGPoint(x: width / 10 * CGFloat(i), y: width),
//                    ])
//                    path.addLines([
//                        CGPoint(x: 0, y: width / 10 * CGFloat(i)),
//                        CGPoint(x: width, y: width / 10 * CGFloat(i)),
//                    ])
//                }
//                .stroke(Color.black.opacity(0.1))
//            }
//        }
//    }
// }

// struct MatrixView_Previews: PreviewProvider {
//    static var previews: some View {
//        MatrixView()
//            .frame(width: 300, height: 300)
//    }
// }
