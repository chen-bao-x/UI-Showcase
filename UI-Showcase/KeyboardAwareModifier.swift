//
//  KeyboardAwareModifier.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/24.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import SwiftUI

struct KeyboardAwareModifieradfasf: View {
    @State private var name = "dasfafasfsafasf"
    var body: some View {
        VStack {
            Spacer()
            TextField("", text: $name)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 20)
                        .foregroundColor(.gray)
                )
                .modifier(KeyboardAwareModifier())
        }.edgesIgnoringSafeArea(Edge.Set.bottom)
    }
}

struct KeyboardAwareModifier: ViewModifier {
    @State private var keyboardHeight: CGFloat = 0
    
    private var keyboardHeightPublisher: AnyPublisher<CGFloat, Never> {
        Publishers.Merge(
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillShowNotification)
                .compactMap { $0.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect }
                .map { $0.height },
            
            NotificationCenter.default
                .publisher(for: UIResponder.keyboardWillHideNotification)
                .map { _ in CGFloat(0) }
            
        ).eraseToAnyPublisher()
    }
    
    func body(content: Content) -> some View {
        content
            .padding(.bottom, keyboardHeight)
            .onReceive(keyboardHeightPublisher) { self.keyboardHeight = $0 }
            .animation(Animation
                .spring(response: 0.4, dampingFraction: 0.9, blendDuration: 1.0))
        
//            .animation(Animation.spring(response: 0.45, dampingFraction: 0.8, blendDuration: 4000.0))// MARK:  最接近的版本
        
//            .animation(Animation.easeInOut(duration: 0.3))
        
//            .animation(Animation.spring(response: 0.45, blendDuration: 1.0)) // MARK: 最接近的版本
        
        // .animation(Animation.spring())
        
//            .animation(Animation.interpolatingSpring(mass: Double(2.5),
//                                                     stiffness: Double(1500),
//                                                     damping: Double(5000),
//                                                     initialVelocity: Double(0.5)))
//            .animation(Animation.spring())
        
//            .animation(Animation.spring(response: Double(0.5),
//                                        dampingFraction: Double(0.3),
//                                        blendDuration: Double(0.2)))
        
//            .animation(Animation.interactiveSpring(response: 0.45, dampingFraction: 0.9, blendDuration: 1.0))
        
//            .animation(Animation.spring( response: 0.45,
//                                         dampingFraction: Double(3),
//                                         blendDuration: 1.0))
        
//        UIView.animate(withDuration: T##TimeInterval,
//         delay: T##TimeInterval,
//         usingSpringWithDamping: T##CGFloat,
//         initialSpringVelocity: T##CGFloat,
//         options: UIView.AnimationOptions,
//         animations: T##() -> Void,
//         completion: T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void)
        
//            .animation(Animation.spring( response: 0.25))
        
//            .animation(Animation.interpolatingSpring(mass: Double(3),
//                                                     stiffness: Double(1000),
//                                                     damping: Double(500),
//                                                     initialVelocity: Double(0.5)))
//                                         let ani = CASpringAnimation(keyPath: "position")
//                                         ani.damping = 500
//                                         ani.stiffness = 1000
//                                         ani.mass = 3
//                                         ani.duration = 0.5
        
//            .animation(Animation.timingCurve(Double(7),
//                                             Double(7),
//                                             Double(7),
//                                             Double(7)))
//            .animation(Animation.interactiveSpring())
        
//            .animation(Animation.easeIn(duration: 0.25))
        
//            .animation(Animation.linear(duration: 0.25))
    }
}

extension View {
    func keyboardAwarePadding() -> some View {
        return ModifiedContent(content: self, modifier: KeyboardAwareModifier())
    }
}

struct asdfljasdsdfasfasdf<T: View>: UIViewControllerRepresentable {
    init(@ViewBuilder view: @escaping () -> T) {
        self.view = view
    }
    
    let view: () -> T
    
    func makeUIViewController(context: Context) -> dsafdafadfadfsdf<T> {
        let a = asdfljasdsdfasfasdf.dsafdafadfadfsdf<T>()
        a.content = self.view()
        
        return a
    }
    
    func updateUIViewController(_ uiViewController: dsafdafadfadfsdf<T>, context: Context) {}
    
    class dsafdafadfadfsdf<Content: View>: UIViewController {
        var content: Content!
        
        override func viewDidLoad() {
            NotificationCenter.default
                .addObserver(self,
                             selector: #selector(self.onKeyboardWillChangeFrame),
                             name: UIResponder.keyboardWillShowNotification,
                             object: nil)
            
            let a = UIHostingController(rootView: self.content!).view!
            self.view.frame = a.frame
//            self.view.addSubview(UIHostingController(rootView: self.content!).view)
            self.view.addSubview(a)
        }
        
        /**
         键盘显示隐藏事件监听
         */
        @objc func onKeyboardWillChangeFrame(notification: NSNotification) {
            // 1、将通知中的数据转换成NSDictionary
            let dict = NSDictionary(dictionary: notification.userInfo!)
            
            // 2、获取键盘最后的Frame值
            let keyboardFrame = dict[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
            
            // 3、获取键盘移动值
            let ty = keyboardFrame.origin.y - view.frame.height
            
            // 4、获取键盘弹出动画事件
            let duration = dict[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
            UIView.animate(withDuration: duration, animations: { () -> Void in
                //            5、设置整个屏幕随键盘移动
                //            self.toolbar.transform =
//                self.view.transform =
                self.view.subviews[0].transform =
                    CGAffineTransform(translationX: 0, y: ty)
            })
            
            //        键盘弹出隐藏所执行的操作数据
            //        UIKeyboardAnimationCurveUserInfoKey = 7;
            //        UIKeyboardAnimationDurationUserInfoKey = "0.25";  键盘弹出/隐藏时动画时间
            //        UIKeyboardBoundsUserInfoKey = "NSRect: {{0, 0}, {375, 258}}";
            //        UIKeyboardCenterBeginUserInfoKey = "NSPoint: {187.5, 796}";
            //        UIKeyboardCenterEndUserInfoKey = "NSPoint: {187.5, 538}";
            //        UIKeyboardFrameBeginUserInfoKey = "NSRect: {{0, 667}, {375, 258}}";
            //        UIKeyboardFrameEndUserInfoKey = "NSRect: {{0, 409}, {375, 258}}";
        }
    }
}
