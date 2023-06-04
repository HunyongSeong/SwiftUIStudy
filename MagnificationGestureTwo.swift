//
//  MagnificationGestureTwo.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/02.
//

import SwiftUI

struct MagnificationGestureTwo: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0

    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currentAmount + lastAmount)
            // scaleEffect에서 1은 100% 비율을 의미
            .gesture(
                MagnificationGesture()
                    .onChanged { value in // 확대할 때 동작, value의 값이 증가
                        currentAmount = value - 1
                        // -1 하는 이유는 -1 하지 않을 경우에 확대시 바로 2배 이상으로 커짐
                    }
                    .onEnded { value in // 손가락을 놓았을 때, 크기를 그대로 고정
                        lastAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

struct MagnificationGestureTwo_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureTwo()
    }
}
