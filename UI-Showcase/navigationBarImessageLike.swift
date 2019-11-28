//
//  navigationBarImessageLike.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/20.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct navigationBarImessageLike: View {
    @State var off = CGSize(width: 100, height: 42)
    @State var hidden = false

    var b = Text("Navigation Bar\t\t") + Text("0").foregroundColor(.blue)
    var body: some View {
        NavigationView {
//            GeometryReader { _ in
            ZStack {
                ScrollView {
                    Divider().offset(x: 0, y: -16)
                    Text("").frame(height: 146)
//                    HStack {
//                        "Bar".foregroundColor(.black).font(.largeTitle)
//                        Spacer()
//                        c().font(.headline)
//                        d().font(.headline)
//                    }.foregroundColor(.blue)
//                        .padding(.horizontal)

                    GeometryReader { g -> Text in
                        let frame = g.frame(in: CoordinateSpace.global)
                        self.off.height = frame.origin.y

                        if frame.origin.y < 146 {
                            self.hidden = false
                        } else {
                            self.hidden = true
                        }
                        return Text("\(self.off.height)")
                    }.background(Color.blue)

//                "    akldjflj"
                }
//            .edgesIgnoringSafeArea(.all)
                .navigationBarTitle(self.b)
                .navigationBarItems(
                    trailing: Button(action: {}) {
                        HStack {
                            c().font(.headline)
                            d().font(.headline)
                        }.foregroundColor(.blue)
                    }
                )
//                .navigationBarHidden(self.hidden)

//                .opacity(self.hidden ? 10 : 0)
            }.edgesIgnoringSafeArea(.all)
//                .background(Color.black)
        }
    }
}

struct navigationBarImessageLike_Previews: PreviewProvider {
    static var previews: some View {
        navigationBarImessageLike()
    }
}

struct c: View {
    var body: some View {
        ZStack {
            Circle().foregroundColor(Color.gray.opacity(0.3))
            Image(systemName: "ellipsis").padding(10)
        }.frame(width: 40)
    }
}

struct d: View {
    var body: some View {
        ZStack {
            Circle().foregroundColor(Color.blue)
            Image(systemName: "square.and.pencil").foregroundColor(Color.white).padding(10)
        }.frame(width: 40)
    }
}
