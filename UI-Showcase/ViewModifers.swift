//
//  ViewModifers.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import SwiftUI
struct ViewModifers: View {
    @State private var sheeting: Bool = false
    var body: some View {
        VStack {
            Text("18787765678")
                .textContentType(.telephoneNumber)

            Text("https://apple.com")
                .textContentType(.URL)
        }
            .modifier(PropertyChanger())
    }
}

struct ViewModifers_Previews: PreviewProvider {
    static var previews: some View {
        ViewModifers()
    }
}
