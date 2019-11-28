//
//  ColorPicker.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct ColorPicker: View {
    @Binding var stateColor: Color
    var body: some View {
        VStack {
            RoundedRectangle(cornerRadius: 30)
                .foregroundColor(self.stateColor)

            List {
                ForEach(0..<self.color.count, id: \.self) { i in
                    Button(action: {
                        self.stateColor = self.color[i]
                    }) {
                        HStack {
                            Text(self.colorName[i])
                            Spacer()
                            Rectangle()
                                .frame(width: 400)
                                .foregroundColor(self.color[i])
                        }
                    }
                }
            }
        }
    }

    let color: [Color] = [.blue, .gray, .green, .orange,
                          .pink, .primary, .purple, .red, .
                              secondary, .white, .yellow, .black, .clear]

    let colorName: [String] = ["blue", "gray", "green", "orange",
                               "pink", "primary", "purple", "red",
                               "secondary", "white", "yellow", "black", "clear"]
}

struct ColorPicker_Previews: PreviewProvider {
    static var previews: some View {
        ColorPicker(stateColor: .constant(.green))
    }
}
