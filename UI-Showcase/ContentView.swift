//
//  ContentView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/14.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import SwiftUI

extension String: View {
    public var body: some View {
        Text(self)
    }
}

struct ContentView: View {
    @State private var v: Float = 0
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: halfModal()) { "halfModal" }

                NavigationLink(destination: ViewModifers()) { "ViewModifers" }

                NavigationLink(destination:

                    Photo().environmentObject(p.有权限么)
                        .onDisappear {
                            print("onDisappear")
                }) { "Photos" }

                Gestures()

                Drawing_and_Animation()

                View_Layout_and_Presentation()

                Views_and_Controls()

                UI_组件()
            }

            .navigationBarTitle(Text(self.text), displayMode: .automatic)
        }

        .navigationViewStyle(StackNavigationViewStyle())
    }

    @State private var text: String = "updating"
    @State private var searchBarIsActive: Bool = false
}

var b = (0, 1, "a")

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.colorScheme, .dark)
    }
}

struct diGui: View {
    var body: some View {
        NavigationLink(destination: diGui()) {
            Text(" asfasdfasfasfd ")
        }
    }
}

extension UINavigationController {
    open override func viewDidLoad() {
        super.viewDidLoad()

        let standardAppearance = UINavigationBarAppearance()
//
//        standardAppearance.configureWithTransparentBackground() // 透明背景
//
//        standardAppearance.configureWithDefaultBackground()
//        standardAppearance.backgroundColor = nil
//        standardAppearance.backgroundImage = UIImage(named: "p3")!
//
//        standardAppearance.setBackIndicatorImage(UIImage(named: "p3")!, transitionMaskImage: UIImage(named: "p3")!)
//
        standardAppearance.configureWithOpaqueBackground() // 不透明背景
        standardAppearance.shadowImage = nil // 去掉 navigationBar 下面的阴影
        standardAppearance.shadowColor = .clear
        navigationBar.standardAppearance = standardAppearance

//        navigationItem.titleView = UIHostingController(rootView: segment()).view
//        navigationItem.titleView = UIImageView(image: UIImage(named: "p1"))
//
//        topViewController?.addChild(self)
    }
}

struct bor: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(.horizontal)
            .padding(.vertical, 5)
            .background(
                RoundedRectangle(cornerRadius: 10, style: RoundedCornerStyle.continuous)
                    .stroke(Color.gray)
                    .foregroundColor(.clear)
            )
            .padding()
    }
}

struct 可折叠Section<Content: View>: View {
    init(headerTitle: Text, @ViewBuilder content: @escaping () -> Content) {
        self.content = content()
        text = headerTitle
    }

    var content: Content
    let text: Text
    @State private var toggle: Bool = true

    var body: some View {
        Section(header: header) {
            if self.toggle == true {
                content
            }
        }
    }

    var header: some View {
        HStack {
            self.text.font(Font.title.bold())

            Spacer()

            Group {
                self.toggle ?
                    Image(systemName: "chevron.compact.down")
                    :
                    Image(systemName: "chevron.compact.up")
            }.foregroundColor(.gray)
        }
        /// 挡住 Section header 的背景色, 这样只改变当前的 View,  挺好
        .padding([.horizontal, .top])
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .foregroundColor(self.colorScheme == .dark ? .white : .black)
        .background(Color("黑白"))
        .edgesIgnoringSafeArea(.all)
        .onTapGesture {
            self.toggle.toggle()
        }
    }

    @Environment(\.colorScheme) var colorScheme: ColorScheme
}
