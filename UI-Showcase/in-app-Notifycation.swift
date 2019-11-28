//
//  in-app-Notifycation.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/19.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct in_app_Notifycation: View {
    @GestureState var dragAmount = CGSize.zero
    var body: some View {
        Image(systemName: "plus")
            .font(.largeTitle)
            .offset(dragAmount)
            .gesture(
                DragGesture().updating($dragAmount) { value, state, _ in
                    state = value.translation
                }
            )
            .transition(.asymmetric(insertion: .move(edge: .leading), removal: .move(edge: .bottom)))
    }
}

struct in_app_Notifycation_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            in_app_Notifycation()
                .environment(\.colorScheme, .light)
        }
    }
}

