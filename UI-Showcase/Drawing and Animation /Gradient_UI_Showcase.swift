//
//  Gradient_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Gradient_UI_Showcase: View {
    var body: some View {
        VStack {
            AngularGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center)

            LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: .leading, endPoint: .trailing)

            RadialGradient(gradient: Gradient(colors: [Color.red, Color.blue]), center: .center, startRadius: 5, endRadius: 500)
        }
    }
}

struct Gradient_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Gradient_UI_Showcase()
    }
}
