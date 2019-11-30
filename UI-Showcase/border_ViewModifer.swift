//
//  border_ViewModifer.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct borderChanger: View {
    @Binding var border: AllPropertys.Border

    var body: some View {
        List {
            Toggle(isOn: self.$border.WhetherShowBoder) {
                "show border:  \(self.border.WhetherShowBoder ? "已显示" : "已隐藏")"
            }

            Picker(selection: self.$border.useImage, label: Text("use Image")) {
                "use Image".tag(true)

                "use Color".tag(false)
            }.pickerStyle(SegmentedPickerStyle())

            VStack {
                "width: \(self.border.width)"
                Slider(value: self.$border.width, in: 0...400)
            }

            if self.border.useImage == false {
                NavigationLink(destination: ColorPicker(stateColor: self.$border.color)) { "Color Picker" }
            }
        }
        .navigationBarTitle(Text("Border Changer"))
    }
}

struct border_ViewModifer: ViewModifier {
    @Binding var border: AllPropertys.Border

    func body(content: Content) -> some View {
        Group {
            if self.border.WhetherShowBoder { /// 显示 border
                if self.border.useImage { /// 使用 Image 作为 border
                    content
                        .border(ImagePaint(image: Image("p1")), width: self.border.width)
                } else { ///  使用 Color 作为 border
                    content
                        .border(self.border.color, width: self.border.width)
                }
            } else { /// 不显示 border
                content
            }
        }
    }
}

struct border_ViewModifer_Previews: PreviewProvider {
    static var previews: some View {
        borderChanger(border: .constant(AllPropertys.Border()))
    }
}
