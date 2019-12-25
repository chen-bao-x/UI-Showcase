//
//  KeyboardAwareModifier.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/12/24.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

import Combine

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
//            .animation(Animation.spring(response: 0.45, dampingFraction: 0.8, blendDuration: 4000.0))// MARK:  最接近的版本
            
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


