//
//  SwiftUIView.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/10.
//  Copyright © 2019 chenbao. All rights reserved.
//

import Combine
import SwiftUI

struct SwiftUIView: View {
    @State private var haha: String = "asld;kfj"

    var body: some View {
        ScrollView {
            Text("Hello, World!")

            TextField("user Name", text: .constant(""))
            TextField("user Name", text: .constant(""))
            TextField("user Name", text: .constant(""))

            Button(action: {}) {
                Text("提交")
            }

            TextField("tilte", text: self.$haha.projectedValue)
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}

struct Sub: Subscriber {
    typealias Input = Void

    typealias Failure = Never

    func receive(subscription: Subscription) {
        print("1")
    }

    func receive(_ input: Self.Input) -> Subscribers.Demand {
        print("2")
        return Subscribers.Demand.max(5)
    }

    func receive(completion: Subscribers.Completion<Self.Failure>) {
        print("3")
    }

    var combineIdentifier: CombineIdentifier = CombineIdentifier()
}

var pub = PassthroughSubject<Void, Never>()
var sub = Sub()

func f() {
    _ = pub.subscribe(pub)
    pub.send()
}
