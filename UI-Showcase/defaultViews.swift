//
//  defaultViews.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/10/19.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct defaultViews: View {
    var a: [String] = { () -> [String] in
        var haha: [String] = []
        for i in 1...17 {
            haha.append("p\(i)")
        }
        return haha
    }()

    var body: some View {
        sections()
    }
}

struct defaultViews_Previews: PreviewProvider {
    static var previews: some View {
        Group {
        defaultViews().environment(\.colorScheme, .dark)
            defaultViews().environment(\.colorScheme, .light)
        }
    }
}

// struct sections<Content>: View where Content: View {
struct sections: View {
    var body: some View {
        Form {
            ForEach(0..<10, id: \.self) { i in

                Text("adsfasfas\(i)")
                .modifier(BackGroundCard())
//                Image("p1")
//                .resizable()
//                .scaledToFit()
                    .modifier(singleForm())
            }
        }
    }
}

// 自定义 ViewModifier
struct singleForm: ViewModifier {
    func body(content: Content) -> some View {
        c {
            content
        }
    }

    struct c<Content>: View where Content: View {
        init(@ViewBuilder content: @escaping () -> Content) {
            self.content = content()
        }

        var content: Content
        var body: some View {
            Section {
                VStack {
                    Section {
                        self.content
                    }
                }
            }
//            .padding(.horizontal)
            .listRowBackground(self.back)
        }

        @Environment(\.colorScheme) var colorScheme: ColorScheme

        var back: some View {
            ZStack {
                self.colorScheme == .light ? Color(red: 242 / 255, green: 242 / 255, blue: 242 / 255) : Color.black
                
                
//                RoundedRectangle(cornerRadius: 10)
//                    .padding(.horizontal)
//                    .foregroundColor(Color.white)
//
            }
        }
    }
}


struct BackGroundCard: ViewModifier {
   
    
    func body(content: Content) -> some View {
        ZStack (alignment: .leading){
            (self.colorScheme == .light ? Color.white : Color.secondary.opacity(0.2))
                .cornerRadius(5)
                .opacity(0.9)
            
            content
                .padding(.horizontal)
        }
    }
    @Environment(\.colorScheme) var colorScheme: ColorScheme
}

struct lists: View {
    var body: some View {
        VStack {
            AnList("DefaultListStyle")
                .listStyle(DefaultListStyle())

            AnList("GroupedListStyle")
                .listStyle(GroupedListStyle())

            AnList(" CarouselListStyle")
                .listStyle(PlainListStyle())
        }
    }

    struct AnList: View {
        init(_ text: String) { self.text = text }
        var text: String
        var body: some View {
            List {
                ForEach(0..<5, id: \.self) { i in
                    Text("\(self.text)\t\(i)")
                }
            }
        }
    }
}

struct pickers: View {
    var body: some View {
        List {
            anPicker("DefaultPickerStyle").pickerStyle(DefaultPickerStyle())
                .border(Color.red)
            anPicker("WheelPickerStyle").pickerStyle(WheelPickerStyle())
                .border(Color.red)
            anPicker("SegmentedPicker").pickerStyle(SegmentedPickerStyle())
                .border(Color.red)
        }
    }

    struct anPicker: View {
        init(_ text: String) { self.text = text }
        var text: String
        @State private var selection: Int = 0
        var body: some View {
            Picker(selection: self.$selection, label: self.text) {
                Text("1").tag(1)
                Text("2").tag(2)
            }
        }
    }
}


