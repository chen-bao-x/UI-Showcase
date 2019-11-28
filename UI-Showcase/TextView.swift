//
//  TextView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/22.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct TextView: View {
    var body: some View {
        m {
            Text("hello")
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView()
    }
}

struct m<Content>: View where Content: View {
    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content()
    }

    var content: Content

    var body: some View {
        ScrollView {
            VStack {
                self.content
                    .font(self.fonts[self.font])
                    .foregroundColor(self.colors[self.color])
                    .background(self.colors[self.backgroundColor])
                    .padding(Edge.Set.all, nil)
                    .border(Color.red, /* confirm to BorderStyle */
                            width: 1)
                    .blur(radius: 1, opaque: false)
                    .brightness(0)
                    .clipShape(Circle()) // Shape
            }

            ScrollView(Axis.Set.horizontal, showsIndicators: false) {
                HStack {
                    self.fontPicker

                    self.foregroundColorPicker

                    self.backgroundColorPicker
                }
            }
        }
    }

    @State private var color: String = "black"
    let colors: [String: Color] = ["clear": Color.clear,
                                   "black": Color.black,
                                   "white": Color.white,
                                   "gray": Color.gray,
                                   "red": Color.red,
                                   "green": Color.green,
                                   "blue": Color.blue,
                                   "orange": Color.orange,
                                   "yellow": Color.yellow,
                                   "pink": Color.pink,
                                   "purple": Color.purple,
                                   "primary": Color.primary,
                                   "secondary": Color.secondary]
    var foregroundColorPicker: some View {
        Picker(selection: self.$color, label: Text("选中的颜色")) {
            Group {
                Text("clear").tag("clear")
                Text("black").tag("black")
                Text("white").tag("white")
                Text("gray").tag("gray")
                Text("red").tag("red")
                Text("green").tag("green")
                Text("blue").tag("blue")
                Text("orange").tag("orange")
            }

            Group {
                Text("yellow").tag("yellow")
                Text("pink").tag("pink")
                Text("purple").tag("purple")
                Text("primary").tag("primary")
                Text("secondary").tag("secondary")
            }
        }.padding()
    }

    @State private var backgroundColor: String = "clear"
    var backgroundColorPicker: some View {
        Picker(selection: self.$backgroundColor, label: Text("选中的颜色")) {
            Group {
                Text("clear").tag("clear")
                Text("black").tag("black")
                Text("white").tag("white")
                Text("gray").tag("gray")
                Text("red").tag("red")
                Text("green").tag("green")
                Text("blue").tag("blue")
                Text("orange").tag("orange")
            }

            Group {
                Text("yellow").tag("yellow")
                Text("pink").tag("pink")
                Text("purple").tag("purple")
                Text("primary").tag("primary")
                Text("secondary").tag("secondary")
            }
        }.padding()
    }

    @State private var font: String = "largeTitle"
    let fonts = ["largeTitle": Font.largeTitle,
                 "title": Font.title,
                 "headline": Font.headline,
                 "subheadline": Font.subheadline,
                 "body": Font.body,
                 "callout": Font.callout,
                 "footnote": Font.footnote,
                 "caption": Font.caption]
    var fontPicker: some View {
        Picker(selection: self.$font, label: Text("选中的字体")) {
            Text("largeTitle").tag("largeTitle")
            Text("title").tag("title")
            Text("headline").tag("headline")
            Text("subheadline").tag("subheadline")
            Text("body").tag("body")
            Text("callout").tag("callout")
            Text("footnote").tag("footnote")
            Text("caption").tag("caption")
        }.padding()
    }
}

struct PrimaryLabel: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(Color.red)
            .foregroundColor(Color.white)
            .font(.largeTitle)
    }
}
