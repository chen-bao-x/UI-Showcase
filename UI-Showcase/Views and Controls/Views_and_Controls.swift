//
//  Views_and_Controls.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Views_and_Controls: View {
    var body: some View {
        可折叠Section(headerTitle: Text("Views And Controls")) {
            Section {
                // PasteButton()

                NavigationLink(destination: TextView()) { "TextView" }

                NavigationLink(destination: Text_UI_Showcase()) { "Text" }

//                NavigationLink(destination: TextField_UI_Showcase()) { "TextField" }
                TextField_UI_Showcase()
//                NavigationLink(destination: SecureField_UI_Showcase()) { "SecureField" }
                SecureField_UI_Showcase()
//                NavigationLink(destination: Image_UI_Showcase()) { "Image" }
                Toggle_UI_Showcase()
                Button_UI_Showcase()

                NavigationLink(destination: NavigationLink_UIShowcase()) { "NavigationLink" }
            }

            Section {
                #if os(macOS)
                NavigationLink(destination: MenuButton_UI_Showcase()) { "MenuButton" }
                #endif

                NavigationLink(destination: EditButton_UI_Showcase()) { "EditButton" }

                NavigationLink(destination: Picker_UI_Showcase()) { "Picker" }

                NavigationLink(destination: DatePicker_UI_Showcase()) { "DatePicker" }

                Slider_UI_Showcase()

                Stepper_UI_Showcase()
            }
        }
    }
}

struct Views_and_Controls_Previews: PreviewProvider {
    static var previews: some View {
        Views_and_Controls()
    }
}
