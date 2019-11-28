//
//  LongPressGesture_UI_Showcase.swift
//  UI-Showcase
//
//  Created by 陈宝 on 2019/11/28.
//  Copyright © 2019 chenbao. All rights reserved.
//

import SwiftUI

struct LongPressGesture_UI_Showcase: View {
   
    @GestureState var isDetectingLongPress = false
    @State var totalNumberOfTaps = 0
    @State var doneCounting = false
    
    var body: some View {
        let press = LongPressGesture(minimumDuration: 1)
            .updating($isDetectingLongPress) { currentState, gestureState, transaction in
                gestureState = currentState
        }.onChanged { _ in
            self.totalNumberOfTaps += 1
        }
        .onEnded { _ in
            self.doneCounting = true
        }
        
        return VStack {
            Text("\(totalNumberOfTaps)")
                .font(.largeTitle)
            
            Circle()
                .fill(doneCounting ? Color.red : isDetectingLongPress ? Color.yellow : Color.green)
                .frame(width: 100, height: 100, alignment: .center)
                .gesture(doneCounting ? nil : press)
        }
    }
}

struct LongPressGesture_UI_Showcase_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGesture_UI_Showcase()
    }
}
