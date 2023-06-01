//
//  LongPressGestureBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/01.
//

import SwiftUI

struct LongPressGestureBootcamp: View {
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false

    var body: some View {
        
//        VStack {
//            Rectangle()
//                .fill(isSuccess ? Color.green : Color.blue) // isSuccess 참/거짓에 의해 색깔 변경
//                .frame(maxWidth: isComplete ? .infinity : 0) // isComplete 참 거짓에 의해서 넓이를 조정
//                .frame(height: 55)
//                .frame(maxWidth: .infinity, alignment: .leading)
//                .background(Color.gray)
//
//
//            HStack {
//                Text("CLICK HERE")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(10)
//                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
//                        // start of press -> min duration // 1초 이상 누르기, 50만큼 거리 // 정사각형
//                        if isPressing { // isPressing == true
//                            withAnimation(.easeInOut(duration: 1.0)) {
//                                isComplete.toggle()
//                            }
//                        } else {  // isPressing == falase
//                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { // 0.1초의 지연
//                                if !isSuccess { // 성공하면 오른쪽 끝까지, 성공 못하면 되돌 리기 위함
//                                    withAnimation(.easeInOut) {
//                                        isComplete = false
//                                    }
//                                }
//                            }
//                        }
//
//                    } perform: { // <- perform의 역할 // 클로저의 역할...!.. 두번째 꺼도 //맥개변수 4개의 역할
//                        // at the min duration
//                        withAnimation(.easeInOut) { // 탭 제스쳐로 성공, 실패
//                            isSuccess = true
//                        }
//                    }
//
//                Text("RESET")
//                    .foregroundColor(.white)
//                    .padding()
//                    .background(Color.black)
//                    .cornerRadius(10)
//                    .onTapGesture {
//                        isComplete = false
//                        isSuccess = false
//                    }
//
//            }
//        }
        
 //// =====================================================
        
        Text(isComplete ? "COMPLETED" : "NOT COMPLETE")
            .padding()
            .padding(.horizontal)
            .background(isComplete ? Color.green : Color.gray)
            .cornerRadius(10)
            .onTapGesture { // 일반적인 탭 제스쳐
                isComplete.toggle() // 
            }
            .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 100) { // (minimumDuration: 1.0, maximumDistance: 100) 버튼을 터치한 상태에서 손가락이 버튼으로부터 거리가 최대 100 까지는 작동함
                isComplete.toggle()
            }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
