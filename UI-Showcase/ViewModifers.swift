//
//  ViewModifers.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct ViewModifers: View {
    var body: some View {
        VStack {
            Text("hello")
        }
        .modifier(PropertyChanger())
    }
}

struct ViewModifers_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifers()
    }
}
