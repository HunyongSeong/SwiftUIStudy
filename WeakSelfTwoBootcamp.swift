//
//  WeakSelfTwoBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/16.
//

import SwiftUI

struct WeakSelfTwoBootcamp: View {
    
    @AppStorage("count") var count: Int?
    
    init() {
        count = 0 // 생성시, count = 0
    }
    
    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay (
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {
    // @StateObjece <- @ObservableObject <- @Published
    
    @StateObject var vm = WeakSelfSecondScreenViewModel()
    /* @StateObject는 SwiftUI에서 상태를 관찰 가능하게 만들어주는 속성 중 하나입니다.
    이렇게 하면 vm 객체의 상태가 변경될 때마다 SwiftUI가 자동으로 해당 뷰를 업데이트합니다. */
    
    //일반적으로 @StateObject를 사용하여 옵저버블 객체 (ObservableObject) 인스턴스를 만들고 사용합니다.

    var body: some View {
        
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundColor(.red)
            
            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {
    // 이 프로토콜을 채택한 객체는 (**관찰 가능한 속성**)을 가질 수 있으며,
    // 이러한 속성이 변경되면 자동으로 뷰에 알림을 보내어 UI를 업데이트할 수 있습니다.
    @Published var data: String? = nil
    //@Published는 프로퍼티 앞에 붙여서 해당 프로퍼티를 (**관찰 가능한 속성**)으로 만들어줍니다.
    // 이 속성은 값이 변경될 때마다 자동으로 변경 이벤트를 발생시키고, 해당 변경사항을 관찰하고 있는 뷰에 알리게 됩니다.
    init() {
        print("Initialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        // count 값이 + 1 된다는 의미.
        getData() //클릭시, 500 초 후에 실행이 됨
    }
    
    deinit { // 원래는 사라져야 하지만 5초 동안 동작이 걸려있어서 클릭 후 500초동안 사라지지 못함.
        // 숫자 개수만큼 뷰가 백그라운드에 살아 있게 된다.
        print("Deinitialize Now")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }
    
    func getData() {
        
//        DispatchQueue.global().async {
//            self.data = "New Data!!!!"
//        }
//        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { // 500초 걸림
//            self.data = "New Data!!!!" // self.data 에 대한 강력한 참조
//        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "New Data!!!!" // self에 대해서 약한 참조
            // self는 이제 선택 사항이므로 업데이트 되는 이 데이터에 대한 참조는 있지만, 이 클래스가 활성 상태를 유지할 필요는 없다고 선언 -> 클래스 초기화 해제 가능
            
            // 실제 데이터를 화면(2)에서 다운받는 경우에 우리가 다른 화면(1)으로 이동하게 되면, 이전에 화면(2)은 필요가 없다. 하지만 데이터를 다운받고 있는 중이기 때문에 이전의 화면(2)은 활성화 상태이다. 그리고 우리는 약한 참조를 통해서 활성화 상태를 유지할 필요가 없다고 알려줄 수 있다.
        }
    }
}

struct WeakSelfTwoBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfTwoBootcamp()
    }
}
