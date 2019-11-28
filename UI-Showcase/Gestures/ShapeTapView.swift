//
//  ShapeTapView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct ShapeTapView: View {
    @State private var text: String = "text"

    var body: some View {
        VStack {
            self.text

            ZStack {
                "Tap Me"
                Circle()
                    .fill(Color.blue)
                    .frame(width: 100, height: 100, alignment: .center)

            }.gesture(
                TapGesture()
                    .onEnded { _ in
                        self.text = "View tapped!"
                    }
            )
        }
    }
}

struct ShapeTapView_Previews: PreviewProvider {
    static var previews: some View {
        ShapeTapView()
    }
}
