//
//  WeekSelfBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/10.
//
// 실제로 응용 프로그램을 만들 때 중요한 개념입니다.

//Async 개념 정리 추가 및 설명 순서대로 다시 정리

import SwiftUI

struct WeekSelfBootcamp: View {
    
    @AppStorage("count") var count: Int?
//    @AppStorage("count") var count = 0 // 일시, 값이 계속 누적 된다. 앱이 꺼도 저장되기 때문

    init() {
        count = 0
    }
    /* @AppStorage는 SwiftUI에서 UserDefaults를 통해 데이터를 간편하게 저장하고 검색하는 데 사용되는 프로퍼티 래퍼입니다.
     
     @AppStorage 프로퍼티 래퍼는 일반적으로 @State 또는 @StateObject와 함께 사용됩니다.
     @AppStorage는 UserDefaults에서 값을 가져와서 해당 프로퍼티에 할당하거나, 프로퍼티의 값을 UserDefaults에 저장합니다.
     
     해당 코드 @AppStorage("count") var count: Int?은 "count"라는 키를 사용하여 UserDefaults에 정수형 데이터를 저장하거나 검색합니다. */
    
    
    /*
     UserDefaults는 iOS, macOS, watchOS 및 tvOS에서 앱의 설정 데이터를 저장하고 검색하기 위한 인터페이스를 제공하는 클래스입니다. 이 클래스는 앱의 간단한 상태 정보, 사용자 설정, 환경 변수, 앱의 마지막 상태 등을 저장하기에 유용합니다
     
     UserDefaults는 일반적으로 키-값 쌍으로 데이터를 저장하고, 해당 키를 사용하여 데이터를 검색합니다.

     UserDefaults를 사용하면 다음과 같은 기능을 수행할 수 있습니다:

     데이터 저장: UserDefaults는 다양한 데이터 타입 (Bool, Int, Float, Double, String, Data)을 저장할 수 있습니다. 이 데이터는 앱이 종료되어도 영구적으로 저장됩니다.
     데이터 검색: UserDefaults는 저장된 데이터를 해당 키를 사용하여 검색할 수 있습니다. 저장된 데이터는 해당 키로부터 검색되어 앱에서 사용할 수 있습니다.
     데이터 삭제: UserDefaults는 특정 키에 저장된 데이터를 삭제할 수 있습니다. 이를 통해 앱에서 더 이상 필요하지 않은 데이터를 제거할 수 있습니다.
     */
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeekSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)") // 초기화되는 개수
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}

struct WeekSelfSecondScreen: View {
    
    @StateObject var vm = weakSelfSecondScreenViewModel()
    /* @StateObject는 SwiftUI에서 상태를 관찰 가능하게 만들어주는 속성 중 하나입니다.
    이렇게 하면 vm 객체의 상태가 변경될 때마다 SwiftUI가 자동으로 해당 뷰를 업데이트합니다. */
    
    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
            .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
            // if let data = vm.data: vm의 data 속성을 사용하여 옵셔널 바인딩을 수행합니다.
        }
    }
}

class weakSelfSecondScreenViewModel: ObservableObject {
    /* ObservableObject은 SwiftUI에서 상태를 관찰하고 감지할 수 있는 프로토콜입니다.
     이 프로토콜을 채택한 객체는 관찰 가능한 속성을 가질 수 있으며,
     이러한 속성이 변경되면 자동으로 뷰에 알림을 보내어 UI를 업데이트할 수 있습니다. */
    
    /* ObservableObject 프로토콜을 채택하기 위해서는 다음 조건을 충족해야 합니다:
     
    1. 클래스로 선언되어야 합니다.
    2. @Published 속성이 포함된 프로퍼티가 있어야 합니다. */
    
    @Published var data: String? = nil
    // @Published는 프로퍼티 앞에 붙여서 해당 프로퍼티를 관찰 가능한 속성으로 만들어줍니다. 이 속성은 값이 변경될 때마다 자동으로 변경 이벤트를 발생시키고, 해당 변경사항을 관찰하고 있는 뷰에 알리게 됩니다.
    
    /*
     @Published 속성은 다음과 같은 특징을 가지고 있습니다: - @State?

     변경 가능한 프로퍼티에만 사용할 수 있습니다. (var로 선언된 프로퍼티)
     @Published가 붙은 프로퍼티에 새로운 값을 할당하면, 해당 객체는 자동으로 변경 이벤트를 발생시킵니다.
     관찰 가능한 속성을 가진 ObservableObject에 대한 변경사항은 자동으로 SwiftUI 뷰를 업데이트합니다.
     */
    
    init() { // Second View로 화면을 이동할 때 초기화
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count") // 값을 가져오고
        UserDefaults.standard.set(currentCount + 1, forKey: "count") // 1을 추가

        getData()
    }
    
    deinit { // 뒤로가기 후 Second View로 다시 들어갈 때 초기화 해제
        print("DEINTIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count") // 값을 가져오고
        UserDefaults.standard.set(currentCount - 1, forKey: "count") // 1을 추가
    }
    
    func getData() {
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
//            self.data = "NEW DATA!!!!" // self에 대한 강력한 참조 떄문에 항상 활성화 상태를 유지. -> 숫자 개수만큼 뷰 모델(class weakSelfSecond...)이 백그라운드에 존재 -> deinit을 5초가 지날때까지 실행할 수 없다.
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // 약한 참조를 사용하여 데이터에 대한 참조가 있지만, 이 클래스가 활성 상태를 유지하는데 적대적으로 필요하지 않다는 것을 알려줌 -> 해당 초기화 해제가 가능함을 Xcode에 알려줌
            self.data = "NEW DATA!!!!" // self에 대한 강력한 참조 떄문에 항상 활성화 상태를 유지. -> 숫자 개수만큼 뷰 모델(class weakSelfSecond...)이 백그라운드에 존재 -> deinit을 5초가 지날때까지 실행할 수 없다.
            
            // 사용자를 위해 데이터를 다운로드 하는 것과 같은 긴 작업에는 이 weak self를 추가하는 것이 중요!.
            // 사용자가 다운로드를 하는 화면에서 잠깐 나가있을 떄는 해당 화면이 필요하지 않기 떄문
        }
    }
}

struct WeekSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeekSelfBootcamp()
    }
}


