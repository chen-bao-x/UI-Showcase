//
//  TabView_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct TabView_UI_Showcase: View {
    @State private var selection: Int = 1
    var body: some View {
        TabView(selection: $selection) {
            Text("Tab Content 1").tabItem { Text("Tab Label 1") }.tag(1)
            Text("Tab Content 2").tabItem { Text("Tab Label 2") }.tag(2)
            Text("Tab Content 3").tabItem { Text("Tab Label 3") }.tag(3)
            Text("Tab Content 4").tabItem { Text("Tab Label 4") }.tag(4)
        }
    }
}

struct TabView_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        TabView_UI_Showcase()
    }
}
