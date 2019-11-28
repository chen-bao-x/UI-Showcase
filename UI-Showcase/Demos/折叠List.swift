//
//  折叠List.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/24.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct 折叠List: View {
    init() {
        /// 设置 UITableViewHeaderFooterView 的 颜色, 缺点是: 这个设置是 全局的....
        UITableViewHeaderFooterView.appearance().backgroundColor = UIColor(named: "黑白")
        UITableViewHeaderFooterView.appearance().tintColor = UIColor(named: "黑白")
        ///

        /// List 的 background and tintColor
        UITableView.appearance().backgroundColor = UIColor(named: "黑白")
        UITableView.appearance().tintColor = UIColor(named: "黑白")
        ///
    }

    var body: some View {
        List {
            ForEach(0...5, id: \.self) { _ in
                sec().listRowBackground(Color("黑灰"))
            }
        }
        .listStyle(GroupedListStyle())
    }

    @State private var haha: Bool = false
}

struct 折叠List_Previews: PreviewProvider {
    static var previews: some View {
        折叠List()
    }
}

private struct sec: View {
    @State private var a: [Int] = Array(0...10)

    @State private var height: Bool = false

    var body: some View {
        Section(header: self.header) {
            if self.height {
                EmptyView()
            } else {
                ForEach(self.a, id: \.self) { i in
                    NavigationLink(destination: Text("\(i)")) {
                        Text(
                            (0...10)
                                .map { _ in String(i) }
                                .joined(separator: "")
                        ).listRowBackground(Color("黑灰"))
                    }
                }
            }

        }.background(Color("黑灰"))
    }

    var header: some View {
        HStack {
            Text("Section").font(.title)
            Spacer()
            Group {
                self.a.count > 3 ? Image(systemName: "chevron.down") : Image(systemName: "chevron.right")
            }.foregroundColor(.gray)
        }

        /// 挡住 Section header 的背景色, 这样只改变当前的 View,  挺好
        .padding(.horizontal)
        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
        .foregroundColor(self.colorScheme == .dark ? .white : .black)
        .background(Color("黑白"))
        .edgesIgnoringSafeArea(.all)
        ///

        .onTapGesture {
            self.height.toggle()
        }
    }

    @Environment(\.colorScheme) var colorScheme: ColorScheme
}
