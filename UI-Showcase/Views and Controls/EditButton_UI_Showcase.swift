//
//  EditButton_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct EditButton_UI_Showcase: View {
    @State private var arr: [Int] = Array(0...100)
    var body: some View {
        List {
            ForEach(arr.indices, id: \.self) { i in
                (0...10).map { _ in
                    "\(self.arr[i])"
                }.joined(separator: " ")
            }
            .onDelete { indexSet in

                self.arr.remove(atOffsets: indexSet)
            }
        }
        .navigationBarItems(trailing: EditButton())
    }
}

struct EditButton_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        EditButton_UI_Showcase()
    }
}
