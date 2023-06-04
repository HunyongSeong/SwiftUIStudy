//
//  MagnificationGesture.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/02.
//

import SwiftUI

struct MagnificationGestureBootcamp: View {
    @State private var currentAmount: CGFloat = 0
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Swiftful Thinking")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle().frame(height: 300)
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                // scaleEffect에서 1은 100% 비율을 의미함.
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in // 확대할 때, value의 값이 증가
                            currentAmount = value - 1
                            // -1을 하지 않으면 확대 시 바로 두 배 이상으로 증가
                        }
                        .onEnded { value in // 손을 놓을 시, 사각형이 원래 크기로 변화
                            withAnimation(.spring()) { // 스프링과 같이 부드러운 애니메이션 효과
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("This is the caption for my photo.")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}


struct MagnificationGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureBootcamp()
    }
}
