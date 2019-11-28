//
//  HStackView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/9/21.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct HStackView: View {
    var body: some View {
        GeometryReader { g in
            HStack {
                "Chil View 1"
                    .frame(width: g.size.width / 3 - 20, height: g.size.height - 20)
                    .background(Color.blue)
                    .padding(2)

                "Chil View 2"
                    .frame(width: g.size.width / 3 - 20, height: g.size.height - 20)
                    .background(Color.green)
                    .padding(2)

                "Chil View 3"
                    .frame(width: g.size.width / 3 - 20, height: g.size.height - 20)
                    .background(Color.purple)
                    .padding(2)

            }.edgesIgnoringSafeArea(.bottom)
        }
        .navigationBarTitle("HStack", displayMode: .inline)
    }
}

struct HStackView_Previews: PreviewProvider {
    static var previews: some View {
        HStackView()
    }
}
