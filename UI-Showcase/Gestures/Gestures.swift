//
//  Gestures.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Gestures: View {
    var body: some View {
        可折叠Section(headerTitle: Text("Gestures")) {
            NavigationLink(destination: ShapeTapView()) { "Tap Gesture" }
            NavigationLink(destination: LongPressGesture_UI_Showcase()) { "LongPressGesture" }
            NavigationLink(destination: DragGesture_UI_Showcase()) { "DragGesture" }
        }
    }
}

struct Gestures_Previews: PreviewProvider {
    static var previews: some View {
        Gestures()
    }
}
