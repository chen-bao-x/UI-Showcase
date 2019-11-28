//
//  ScrollView_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct ScrollView_UI_Showcase: View {
    var body: some View {
        ScrollView{
            ForEach(0...1000,id:\.self){
                "Scroll it \($0)"
            }
        }
    }
}

struct ScrollView_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView_UI_Showcase()
    }
}
