//
//  Picker_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Picker_UI_Showcase: View {
    @State private var selection: Int = 0

    @State private var pickerStyles: Int = 0
    var body: some View {
        VStack {
            Picker(selection: $selection, label: Text("SegmentedPickerStyle")) {
                Text("0").tag(0)
                Text("1").tag(1)
                Text("2").tag(2)
            }.pickerStyle(SegmentedPickerStyle())

            Picker(selection: $selection, label: Text("Picker")) {
                Text("0").tag(0)
                Text("1").tag(1)
                Text("2").tag(2)
            }
            .pickerStyle(DefaultPickerStyle())

            Picker(selection: $selection, label: Text("WheelPickerStyle")) {
                Text("0").tag(0)
                Text("1").tag(1)
                Text("2").tag(2)
            }.pickerStyle(WheelPickerStyle())
        }
    }
}

struct Picker_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Picker_UI_Showcase()
    }
}
