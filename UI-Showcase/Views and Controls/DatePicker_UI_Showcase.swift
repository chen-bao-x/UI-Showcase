//
//  DatePicker_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct DatePicker_UI_Showcase: View {
    @State private var date: Date = Date()
    var body: some View {
        VStack {
            DatePicker(selection: $date, label: { "DefaultDatePickerStyle" })
                .datePickerStyle(DefaultDatePickerStyle())

            DatePicker(selection: $date, label: { "WheelDatePickerStyle" })
                .datePickerStyle(WheelDatePickerStyle())
        }
    }
}

struct DatePicker_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        DatePicker_UI_Showcase()
    }
}
