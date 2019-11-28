//
//  View_Layout_and_Presentation.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct View_Layout_and_Presentation: View {
    var body: some View {
        可折叠Section(headerTitle: Text("View Layout and Presentation")) {
            NavigationLink(destination: VStackView()) { "VStack" }
            NavigationLink(destination: HStackView()) { "HStack" }
            NavigationLink(destination: ZStackView()) { "ZStack" }
            NavigationLink(destination: List_UI_Showcase()) { "List" }
            NavigationLink(destination: ScrollView_UI_Showcase()) { "ScrollView" }
            NavigationLink(destination: Form_UI_Showcase()) { "Form" }
            NavigationLink(destination: Divider()) { "Divider" }
            NavigationLink(destination: TabView_UI_Showcase()) { "TabView" }
            NavigationLink(destination: Alert_UI_Showcase()) { "Alert" }
            NavigationLink(destination:  ActionSheet_UI_Showcase()) { " ActionSheet" }
            
        }
    }
}

struct View_Layout_and_Presentation_Previews: PreviewProvider {
    static var previews: some View {
        View_Layout_and_Presentation()
    }
}
