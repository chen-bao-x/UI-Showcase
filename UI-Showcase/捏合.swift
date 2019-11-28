//
//  捏合.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/10/4.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct 捏合: View {
    @ObservedObject var com = Com()
    @State private var c: CGFloat = .zero

    var body: some View {
        ZStack {
            Color.green

            ScrollView {
                ForEach(0..<10, id: \.self) { _ in
                    te(com: self.com)
                }
            }
//                .scaleEffect(self.c)
        }

//        .gesture(MagnificationGesture()
//            .onEnded { _ in
//            }
//            .onChanged { c in
//                self.c = c
//            }
//        )
    }
}

struct 捏合_Previews: PreviewProvider {
    static var previews: some View {
        捏合()
    }
}

struct te: View {
    @ObservedObject var com: Com
    @State var t: CGSize = .zero

    @State private var p: CGPoint = .zero

    @State private var to: Bool = false
    
    
    var body: some View {
//        Text("Hello World!")
//        绝对位置(p: self.$p)
        GeometryReader { g -> VStack<Text> in
            let frame = g.frame(in: CoordinateSpace.global)

            if self.to { self.f(frame.origin) }
            return VStack {
//                Text("\(frame.origin.y)")
                Text("\(self.p.y)")
            }
        }
        .padding()
        .offset(self.t)
        .gesture(DragGesture()
            .onChanged { v in self.t = v.translation }
            .onEnded { _ in
//                if biJiao == .zero {
//                    biJiao = self.p
//                    self.to = false
//                } else {
//                    self.to = true
//                    print(self.com.a.y - self.p.y)
//                }
//                self.p = v.location
                self.to = true
                self.t = .zero
            }
        )
        
        
    }

    func f(_ point: CGPoint) {
        if biJiao == .zero {
            biJiao = point
        } else {
            print("😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄")
            print(
                biJiao.y - point.y
            )
            print("😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄😄")
            biJiao = .zero
        }
    }
}

var biJiao: CGPoint = .zero

class Com: ObservableObject {
    @Published var a: CGPoint = .zero
}

struct 绝对位置: View {
    var p: CGPoint
    @State var t: CGSize = .zero
    var body: some View {
        VStack {
            GeometryReader { g -> Text in
                let frame = g.frame(in: CoordinateSpace.global)
//                self.p = frame.origin
//                 self.f()
                return Text("\(frame.origin.y)")
            }
//            .gesture(DragGesture()
//                .onChanged { v in self.t = v.translation }
//                .onEnded { _ in
//                    if self.p == .zero {
            ////                        self.p = frame.origin
//                    }
//
//                    self.t = .zero
//                }
//            )
        }
    }
}
