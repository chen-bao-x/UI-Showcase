//
//  Image_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct Image_UI_Showcase: View {
    var body: some View {
        Image(systemName: "folder.fill")
            .resizable()
            .scaledToFit()
    }
}

struct Image_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        Image_UI_Showcase()
    }
}
