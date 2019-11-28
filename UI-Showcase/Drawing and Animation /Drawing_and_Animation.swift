//
//  Drawing_and_Animation.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Drawing_and_Animation: View {
    var body: some View {
        可折叠Section(headerTitle: Text("Drawing and Animation")) {
            NavigationLink(destination: Rectangle().padding()) { "Rectangle" }
            NavigationLink(destination: Circle().padding()) { "Circle" }
            NavigationLink(destination:
                RoundedRectangle(cornerRadius: 20).padding()) { "RoundedRectangle" }
            
            NavigationLink(destination: Ellipse().padding()) { "Ellipse" }
            NavigationLink(destination: Capsule().padding()) { "Capsule" }
            NavigationLink(destination: Path_UI_Showcase()) { "Path" }
            NavigationLink(destination: Gradient_UI_Showcase()) { "Gradient" }
        }
    }
}

struct Drawing_and_Animation_Previews: PreviewProvider {
    static var previews: some View {
        Drawing_and_Animation()
    }
}
