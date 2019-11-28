//
//  ZStackView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/21.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

/// /ZStack
struct ZStackView: View {
    @State var c: CGSize = .zero
    @State var r: CGSize = .zero
    var body: some View {
        GeometryReader { g in
            ZStack {
                Rectangle()
                    .frame(width: g.size.width, height: g.size.width)
                    .offset(self.r)
                    .foregroundColor(.green)
                    .gesture(DragGesture()
                        .onChanged { v in
                            self.r.width = v.location.x - v.startLocation.x
                            self.r.height = v.location.y - v.startLocation.y
                        }

                        .onEnded { _ in withAnimation { self.r = .zero } }
                    )

                Circle()
                    .frame(width: g.size.width - 100, height: g.size.width - 100)
                    .foregroundColor(.blue)
                    .shadow(radius: 10)
                    .offset(self.c)
                    .gesture(DragGesture()
                        .onChanged { v in
                            self.c.width = v.location.x - v.startLocation.x
                            self.c.height = v.location.y - v.startLocation.y
                        }

                        .onEnded { _ in withAnimation { self.c = .zero }
                        }
                    )
            }
        }
    }
}

struct ZStackView_Previews: PreviewProvider {
    static var previews: some View {
        ZStackView()
    }
}
