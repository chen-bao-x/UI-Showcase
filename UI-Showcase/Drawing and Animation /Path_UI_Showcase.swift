//
//  Path_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Path_UI_Showcase: View {
    var body: some View {
        Path { p in
            p.move(to: CGPoint(x: 0, y: 0))
            p.addLine(to: CGPoint(x: 300, y: 0))
            p.addLine(to: CGPoint(x: 300, y: 300))
            p.addLine(to: CGPoint(x: 150, y: 450))
            p.addLine(to: CGPoint(x: 0, y: 300))
        }
        .fill(
            LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.green]), startPoint: .top, endPoint: .bottom)
        )
    }
}

struct Path_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Path_UI_Showcase()
    }
}
