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
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                // isSuccess 참/거짓에 의해 색깔 변경 (삼항연산자)
                .frame(maxWidth: isComplete ? .infinity : 0)
                // isComplete 참 거짓에 의해서 넓이를 조정 true = infinity, false = 0
            
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                // 뒤의 사각형의 크기는 infinity
                .background(Color.gray)


            HStack {
                Text("CLICK HERE")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 2.0, maximumDistance: 50) { (isPressing) in //isPressing: Bool
                        // start of press -> min duration 시작부터 최소 지속 시간.
                        if isPressing { // isPressing == true
                            // isPressing의 역할은 버튼을 클릭할 하는 순간 작동되며, else는 손가락을 떼면 다시 작동된다. (2초 라는 제한 없이 그냥 클릭시 적용!)
                            withAnimation(.easeInOut(duration: 1.0)) { // 시작과 끝을 천천히하는 애니메이션 (1 초 동안 작동)
                                isComplete = true // 파란색 박스의 크기를 조정
                            }
                        } else {  // 손가락을 떼면 적용됨!
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { // 0.3초의 지연
                                // 이곳에서 0.3초 지연된다는 것은 클릭시에 0.3초 동안 버튼을 누른것과 같은 효과를 주어서 사각형이 커진다.
                                if !isSuccess { // isSuccess를 먼저 확인 후 성공 못하면 되돌리기 위함.
                                    withAnimation(.easeInOut) {
                                        isComplete = false // 사각형넓이 줄이기
                                    }
                                }
                            } // 최종적으로 손가락을 2초 동안 클릭하지 않으면 다시 파란색 사각형이 되돌아오고, 2초 동안 누르게되면 사각형이 꽉채워지고 초록색으로 변함
                        }
                    } perform: { // <- perform의 역할은 수행하는 역할로, 2초 동안 버튼을 눌렀을 때!.
                        withAnimation(.easeInOut) { // 탭 제스쳐로 성공, 실패
                            isSuccess = true // blue로 컬러변경
                        }
                    }

                Text("RESET")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        isComplete = false // onTapGesture로 리셋버튼을 누르게 되면 바로 사각형 크기가 0이 되고
                        isSuccess = false // 컬러도 blue로 변함. -> 애니메이션 주지 않았기 때문에 바로 바뀜
                    }
            }
        }
    }
}

struct LongPressGestureBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        LongPressGestureBootcamp()
    }
}
