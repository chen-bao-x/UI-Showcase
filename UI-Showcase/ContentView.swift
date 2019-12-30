//
//  ContentView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/14.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import nav
import SwiftUI
extension String: View {
    public var body: some View {
        Text(self)
    }
}

struct ContentView: View {
    @State private var v: Float = 0

    @State private var name: String = "adfdasfasfasf"

    var body: some View {
//        return VStack {
//                Spacer()
//                TextField("title", text: .constant("helofdasfdsa"))
//                asdfljasdsdfasfasdf {
//                    VStack {
//                        TextField("title", text: .constant("helofdasfdsa"))
//                    }
//
//                    .background(Color.green)
//                    .frame(width: 400, height: 400)
//                }
//            }

//        .frame(width: 400, height: 400)
//        .background(Color.blue)
//        let a = Animation.default
//        dump(a)
//        let b = Animation.spring()
//        dump(b)

//        let c =  UIView.animate(withDuration: 0.5,
//                     delay: 0,
//                     usingSpringWithDamping: 1,
//                     initialSpringVelocity: 1,
//                     options: UIView.AnimationOptions.curveEaseInOut,
//                     animations: {},
//                     completion: T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void)

        NavigationView {
            List {
                Group {
                    NavigationLink(destination: KeyboardAwareModifieradfasf()) { "KeyboardAwareModifieradfasf" }
                    NavigationLink(destination: GeastureConflict()) { "GeastureConflict" }

                    NavigationLink(destination: halfModal()) { "halfModal" }

                    NavigationLink(destination: ViewModifers()) { "ViewModifers" }

                    NavigationLink(
                        destination:

                        Photo().environmentObject(p.有权限么)
                            .onDisappear {
                                print("onDisappear")
                            }
                    ) { "Photos" }
                }
                
                Gestures()

                Drawing_and_Animation()

                View_Layout_and_Presentation()

                Views_and_Controls()

                UI_组件()
            }

            .introspectTableView(customize: { (u: UITableView) in
                u.refreshControl = self.uuu
            })

            .navigationBarTitle(Text(self.text), displayMode: .automatic)
            .navigationBarItems(trailing: Button(action: { self.uuu.endRefreshing() }) { Text("tap") })

            .introspectNavigationController(customize: { (n: UINavigationController) in
                let standardAppearance = UINavigationBarAppearance()
                standardAppearance.configureWithOpaqueBackground() // 不透明背景
                standardAppearance.shadowImage = nil // 去掉 navigationBar 下面的阴影
                standardAppearance.shadowColor = .clear
                n.navigationBar.standardAppearance = standardAppearance

                n.navigationBar.compactAppearance = standardAppearance

                n.navigationBar.scrollEdgeAppearance = standardAppearance
            })
        }

        .navigationViewStyle(StackNavigationViewStyle())

        .overlay(halfModal().edgesIgnoringSafeArea(Edge.Set.bottom))
    }

    let uuu = UIRefreshControl()

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

struct adsfadsfdasf: UIViewControllerRepresentable {
    typealias UIViewControllerType = UIViewController

    func makeUIViewController(context: UIViewControllerRepresentableContext<adsfadsfdasf>) -> adsfadsfdasf.UIViewControllerType {
        controll()
    }

    func updateUIViewController(_ uiViewController: adsfadsfdasf.UIViewControllerType, context: UIViewControllerRepresentableContext<adsfadsfdasf>) {}

    class controll: UIViewController {
        var keyboardHeight: CGFloat!

        var bottomConstraint: NSLayoutConstraint!

        // This is to get the keyboyard height
        override func viewWillAppear(_ animated: Bool) {
            NotificationCenter.default.addObserver(
                self,
                selector: #selector(keyboardWillShow),
                name: UIResponder.keyboardWillShowNotification,
                object: nil
            )
        }

        @objc func keyboardWillShow(_ notification: Notification) {
            if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
                let keyboardRectangle = keyboardFrame.cgRectValue
                keyboardHeight = keyboardRectangle.height
                UIView.animate(withDuration: 0.5) {
                    self.bottomConstraint.constant = self.keyboardHeight
                    self.view.layoutIfNeeded()
                }
            }
        }
    }
}
