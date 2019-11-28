//
//  Today.swift
//  BaoIdea
//
//  Created by 陈宝 on 2019/9/11.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

/// : MARK: app Strore 这个动画对知识水平有要求, 改日在做
struct Today: View {
    @State var cardActived = false
    @State var index: Double = 2
    
    @State var c = Card(a: false, b: 0)
    
    @State var counter = 0
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    ForEach(0..<10, id: \.self) { _ in
                        
                        Card(a: true, b: 1).frame(width: UIScreen.main.bounds.width)
                            .padding(0)
                            .onTapGesture {
                                self.c = Card(a: true, b: -1)
                                
                                self.index = 100; self.cardActived.toggle()
                            }
                            .frame(height: 400)
                    }
                    .frame(width: UIScreen.main.bounds.width)
                    滑动加载.font(.largeTitle).foregroundColor(.blue)
                }
            }.frame(width: UIScreen.main.bounds.width)
                .animation(.default)
                .zIndex(10)
            
            if self.cardActived {
                self.c
                    .zIndex(self.index)
                    .background(Color.white)
                    .onTapGesture {
                        self.index = 2
                        withAnimation {
                            self.cardActived.toggle()
                        }
                    }
            }
        }
    }
    
    @State var x: CGFloat = 0
    @State var y: CGFloat = 0
    var 滑动加载: some View {
        GeometryReader { g -> Text in
            let frame = g.frame(in: CoordinateSpace.global)
            self.x = frame.origin.x
            self.y = frame.origin.y
            
            return Text("x: \(self.x)  y: \(self.y)")
        }
    }
}

struct Card: View {
    @State var a: Bool
    var b: Int
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            article().disabled(self.a).zIndex(10)
        }
        .padding(0)
        .frame(width: self.a ? 300 : UIScreen.main.bounds.width, height: self.a ? 400 : UIScreen.main.bounds.height, alignment: .topLeading)
        //        .onTapGesture { withAnimation { self.a.toggle() } }
        .clipped()
        .transition(.moveAndScale)
        .onAppear {
            DispatchQueue(label: "haha").asyncAfter(deadline: DispatchTime.now()) {
                if self.b < 0 { withAnimation { self.a.toggle() } }
            }
        }
    }
}

struct DetalView_Previews: PreviewProvider {
    static var previews: some View {
        Card(a: false, b: 1)
    }
}

struct article: View {
    let a = UIImage(named: "p1")!
    var body: some View {
        GeometryReader { _ in
            ScrollView(showsIndicators: false) {
                ZStack(alignment: .topLeading) {
                    VStack(alignment: .leading) {
                        Text(" ")
                        Text(" ")
                        HStack { Text("hello").zIndex(100); Spacer() }
                        HStack { Text("I'm Good").font(.largeTitle).zIndex(100); Spacer() }
                        
                    }.zIndex(10)
                        .padding(0)
                    
                    Image(uiImage: self.a)
                        .resizable()
                    //                        .scaleEffect(g.size.width / self.a.size.width * 2)
                }
                Text(someText())
            }
        }
        .padding(0)
        .frame(width: UIScreen.main.bounds.width, alignment: .topLeading)
    }
}

func someText() -> String {
    var resault: String = "  "
    for _ in 0...1000 {
        resault = resault + "adf"
    }
    return resault
}

import SwiftUI

// MARK: - Setup

extension AnyTransition {
    static var moveAndScale: AnyTransition {
        AnyTransition.move(edge: .bottom).combined(with: .scale)
    }
}
