//
//  DownloadWithEscapingBootcampTwo.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/21.
//
//

// - (1)
import SwiftUI

struct PostModel: Identifiable, Codable { // 식별 가능하도록
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

/*
 Codable 프로토콜은 Swift의 인코딩 및 디코딩을 지원하는 프로토콜입니다.
 PostModel 구조체의 인스턴스를 JSON 데이터로 인코딩하거나,
 JSON 데이터를 PostModel 구조체의 인스턴스로 디코딩할 수 있습니다.
 
 디코딩(Decoding)은 데이터를 읽어와서 해당 데이터를 구조화된 형태로 변환하는 과정
 */








class DownloadWithEscapingViewModel: ObservableObject { // ObservableObject 프로토콜 채택한 객체는 관찰 가능한 속성 가질 수 있음

    @Published var posts: [PostModel] = [] // @Published 관찰 가능한 속성 / 변경 -> 뷰에 알림

    init() {
        getPost()
    }

    func getPost() {

        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        // url 객채를 생성하고 확인
        
        downloadData(fromURL: url) { returnData in // returnData는 다운로드된 데이터
            if let data = returnData { // 만약 데이터가 담긴다면 -> 아래 data를 [PostModel] 형식으로 디코딩 -> newPost에 담기
                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
                DispatchQueue.main.async { [weak self] in // 비동기를 의미하는 디스패치 대기열
                    self?.posts = newPost // 현재 객체인 posts에 newPost를 추가 // 약한참조 // posts는 메인뷰에서 리스트 뷰에 사용
                    // self?.posts.append(newPost)
                }
                
                /*
                [weak self]를 사용하여 약한 참조로 현재 객체를 캡처하고, DispatchQueue.main.async를 사용하여 메인 큐에서 비동기적으로
                 실행하는 것은 메모리 관리와 UI 업데이트의 안정성을 보장하기 위한 중요한 패턴입니다. (UI 업데이트는 메인 스레드에서 실행되어야함)
                 */
                
            } else {
                print("No data return")
            }
        }
    }

    // URL에서 데이터를 가져오고, 디코딩 후 추가
    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) { // completionHandler는 이것이 끝나고 나서 다루겠다는 의미.
        URLSession.shared.dataTask(with: url) { (data, response, error) in // 데이터, 응답, 오류
            guard
            let data = data, // 데이터 확인
            error == nil, // 에러확인
            let response = response as? HTTPURLResponse, // 응답 확인
            
            
            /* **(1)다운캐스팅을 통해 ( :URLResponse?) -> ( :HTTPURLResponse) 타입으로 변환하면, HTTP 응답에 관련된 세부 정보에 접근할 수 있습니다. 예를 들어, 상태 코드(status code), 헤더 정보(headers), 응답 URL 등을 확인하고 필요에 따라 이러한 정보를 처리할 수 있습니다.

            따라서, (response)를 HTTPURLResponse 타입으로 다운캐스팅하여 HTTP 응답과 관련된 정보에 접근하고 처리할 수 있습니다. */
            
            response.statusCode >= 200 && response.statusCode < 300 else {
                print("Error downloading data.")
                completionHandler(nil) // 오류가 없으면 nil이 반환된다.
                return
            }
    
            completionHandler(data)
            //데이터 다운로드가 완료되고 유효한 데이터가 있는 경우에 해당 데이터를 completionHandler 클로저의 매개변수로 전달하는 역할.
          
        }.resume() // <- 시작기능
        
        // 비동기적으로 지정된 URL에서 데이터를 다운로드하는 작업을 수행하는 함수
        // 비동기적인 방식에서는 데이터 요청을 보낸 후에도 다음 동작을 계속해서 수행할 수 있습니다. 응답을 기다리지 않고, 백그라운드에서 데이터를 받아오는 동작을 수행할 수 있습니다. 이는 네트워크 요청이나 파일 다운로드 등 시간이 오래 걸릴 수 있는 작업을 수행할 때 유용합니다
    }
}


// - (2)
struct DownloadWithEscapingBootcamp: View {

    @StateObject var vm = DownloadWithEscapingViewModel()

    var body: some View {
        List {
            ForEach(vm.posts) { post in // DownloadWithEscapingViewModel()의 posts를 바인딩 / * posts(JSON 데이터의 배열)
                VStack(alignment: .leading) {
                    Text(post.title)
                        .font(.headline)
                    Text(post.body)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
}

struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithEscapingBootcamp()
    }
}
