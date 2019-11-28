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

class asdfafadsf {
    class func asdf(){}
}

struct ContentView: View {
    

    var body: some View {
        NavigationView {
            List {
                Section {
                    NavigationLink(destination: segment()) { "segment" }
                    NavigationLink(destination: VStackView()) { "VStack" }
                    NavigationLink(destination: HStackView()) { "HStack" }
                    NavigationLink(destination: ZStackView()) { "ZStack" }
                    NavigationLink(destination: imageScroll()) { "imageScroll" }
                    NavigationLink(destination: diGui()) { "diGui" }
                    NavigationLink(destination: coloringText()) { "coloringText" }
                    NavigationLink(destination: 动态navigationBar()) { "动态navigationBar" }
                    NavigationLink(destination: SwiftUIView()) { "SwiftUIView" }
                    NavigationLink(destination: 折叠List()) { "折叠List" }
                }
                Section {
                    NavigationLink(destination: segment()) { "segment" }
                }
            }.navigationBarTitle(Text("navigationTitle"), displayMode: .inline)
        }.navigationViewStyle(StackNavigationViewStyle())
            
    }
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

//        let standardAppearance = UINavigationBarAppearance()
//
//        standardAppearance.configureWithTransparentBackground() // 透明背景
//
//        standardAppearance.configureWithDefaultBackground()
//        standardAppearance.backgroundColor = nil
//        standardAppearance.backgroundImage = UIImage(named: "p3")!
//
//        standardAppearance.setBackIndicatorImage(UIImage(named: "p3")!, transitionMaskImage: UIImage(named: "p3")!)
//
//        standardAppearance.configureWithOpaqueBackground() // 不透明背景
//        standardAppearance.shadowImage = nil // 去掉 navigationBar 下面的阴影
//        standardAppearance.shadowColor = .clear
//        navigationBar.standardAppearance = standardAppearance

        navigationItem.titleView = UIHostingController(rootView: segment()).view
        navigationItem.titleView = UIImageView(image: UIImage(named: "p1"))

        topViewController?.addChild(self)
    }
}

