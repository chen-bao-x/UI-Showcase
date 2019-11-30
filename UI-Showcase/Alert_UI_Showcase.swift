//
//  Alert_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Alert_UI_Showcase: View {
    @State private var tap: Bool = false
    @State private var message: Bool = false
    @State private var Alert_Button_default: Bool = false
    @State private var Alert_Button_cancel: Bool = false
    @State private var five: Bool = false
    var body: some View {
        VStack {
            Button(action: { self.tap.toggle() }) {
                Text("tap")
                    .alert(isPresented: $tap) { () -> Alert in
                        Alert(title: Text("Text"))
                    }
            }

            Button(action: { self.message.toggle() }) {
                Text("Alert with message")
                    .alert(isPresented: $message) { () -> Alert in
                        Alert(title: Text("Text"), message: Text("message"))
                    }
            }

            Button(action: { self.Alert_Button_default.toggle() }) {
                Text("Alert with message with dismissButton: Alert.Button.default")
                    .alert(isPresented: $Alert_Button_default) { () -> Alert in
                        Alert(title: Text("Text"), message: Text("message"), dismissButton: Alert.Button.default(Text("dismissButton: Alert.Button.default")))
                    }
            }

            Button(action: { self.Alert_Button_cancel.toggle() }) {
                Text("Alert with message with dismissButton: Alert.Button.default")
                    .alert(isPresented: $Alert_Button_cancel) { () -> Alert in
                        Alert(title: Text("Text"), message: Text("message"), dismissButton: Alert.Button.cancel())
                    }
            }

            Button(action: { self.five.toggle() }) {
                Text("tap")
                    .alert(isPresented: $five) { () -> Alert in
                        Alert(title: Text("Text"), message: Text("message"),
                              primaryButton: Alert.Button.default(Text("default")),
                              secondaryButton: Alert.Button.cancel())
                    }
            }
        }
    }
}

struct Alert_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Alert_UI_Showcase()
    }
}
