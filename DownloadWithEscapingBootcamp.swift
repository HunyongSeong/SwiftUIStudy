//
//  DownloadWithEscapingBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/19.
//

import SwiftUI

struct PostModel: Identifiable, Codable { // 식별 가능하도록
    let userId: Int
    let id: Int
    let title: String
    let body: String
} // 사이트 app.quicktype.io

/*
 Identifiable 프로토콜은 SwiftUI에서 사용되며,
 각 데이터 모델이 고유한 식별자(ID)를 가지고 있음을 나타냅니다.
 이 구조체는 id라는 속성을 가지고 있으며, 이를 통해 데이터를 식별할 수 있습니다.
 
 Codable 프로토콜은 Swift의 인코딩 및 디코딩을 지원하는 프로토콜입니다.
 이를 통해 PostModel 구조체의 인스턴스를 JSON 데이터로 인코딩하거나,
 JSON 데이터를 PostModel 구조체의 인스턴스로 디코딩할 수 있습니다.
 */


class DownloadWithEscapingViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    
    init() {
        getPost()
    }
    
    func getPost() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else { return } //url 객채를 생성하고 확인
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            guard let data = data else {
                print("No data.")
                return
            }
            
            guard error == nil else {
                print("Error: \(String(describing: error))")
                return
            }
            
            guard let response = response as? HTTPURLResponse else { // response :URLResponse?
                print("Invalid response.")
                return
            } //  HTTPURLResponse 타입으로 다운캐스팅하여 확인합니다.
            
            /* 관련 HTTPURLResponse 클래스는 일반적으로 사용되는 URLResponse의 하위 클래스로,
             이 클래스의 개체는 HTTP URL 로드 요청에 대한 응답을 나타내며 응답 헤더와 같은 추가 프로토콜 관련 정보를 저장합니다.
             HTTP 요청을 할 때마다 반환되는 URLResponse 개체는 실제로 HTTPURLResponse 클래스의 인스턴스입니다.
             다운캐스팅을 통해 HTTPURLResponse 타입으로 변환하면, HTTP 응답에 관련된 세부 정보에 접근할 수 있습니다.
             예를 들어, 상태 코드(status code), 헤더 정보(headers), 응답 URL 등을 확인하고 필요에 따라 이러한 정보를 처리할 수 있습니다.

             따라서, (response)를 HTTPURLResponse 타입으로 다운캐스팅하여 HTTP 응답과 관련된 정보에 접근하고 처리할 수 있습니다. */
            
            // https://www.whatap.io/ko/blog/40/
            // http 상태코드 정리
            
            guard response.statusCode >= 200 && response.statusCode < 300 else {
                print("Status code should be 2xx, but is \(response.statusCode)")
                return
            }
            
            print("Successfully Downloaded Data!")
            print(data)
            
            // 유니코드는 국제표준 문자표이고 UTF-8은 유니코드를 인코딩하는 방식이다.
            let jsonString = String(data: data, encoding: .utf8)
            print(jsonString)
            
            let newPost = try? JSONDecoder().decode(PostModel.self, from: data)
            /*
             decode(_:from:) 메서드는 JSONDecoder의 인스턴스 메서드로, JSON 데이터를 디코딩하여 지정된 타입으로 변환합니다.
             첫 번째 인자로는 디코딩할 데이터의 타입을 지정해줍니다. 여기서는 PostModel.self를 사용하여 PostModel 타입으로
             디코딩하겠다는 것을 나타냅니다. 두 번째 인자로는 디코딩할 JSON 데이터를 전달합니다.
             여기서는 data 변수가 JSON 데이터를 담고 있습니다.
             */
            
        }.resume() // <- 시작기능
        
    }
}

struct DownloadWithEscapingBootcamp: View {
    
    @StateObject var vm = DownloadWithEscapingViewModel()
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
