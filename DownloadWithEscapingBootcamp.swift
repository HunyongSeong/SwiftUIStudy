////
////  DownloadWithEscapingBootcamp.swift
////  SwiftUIBootcamp
////
////  Created by David Goggins on 2023/06/19. // 전체 노션으로 틀 만들어서 정리부터하기
////
//
//import SwiftUI
//
//struct PostModel: Identifiable, Codable { // 식별 가능하도록
//    let userId: Int
//    let id: Int
//    let title: String
//    let body: String
//} // 사이트 app.quicktype.io
//
///*
// Identifiable 프로토콜은 SwiftUI에서 사용되며,
// 각 데이터 모델이 고유한 식별자(ID)를 가지고 있음을 나타냅니다.
// 이 구조체는 id라는 속성을 가지고 있으며, 이를 통해 데이터를 식별할 수 있습니다.
//
// Codable 프로토콜은 Swift의 인코딩 및 디코딩을 지원하는 프로토콜입니다.
// 이를 통해 PostModel 구조체의 인스턴스를 JSON 데이터로 인코딩하거나,
// JSON 데이터를 PostModel 구조체의 인스턴스로 디코딩할 수 있습니다.
// */
//
//
//class DownloadWithEscapingViewModel: ObservableObject {
//
//    @Published var posts: [PostModel] = []
//
//    init() {
//        getPost()
//    }
//
//    func getPost() {
//
//        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return } //url 객채를 생성하고 확인
//
//        downloadData(fromURL: url) { returnData in // 완료될 시
//            if let data = returnData {
//                guard let newPost = try? JSONDecoder().decode([PostModel].self, from: data) else { return }
//                DispatchQueue.main.async { [weak self] in // 비동기를 의미하는 디스패치 대기열
//                    self?.posts = newPost // 현재 객체인 posts에 newPost를 추가 // 약한참조 // posts는 메인뷰에서 리스트 뷰에 사용
//                }
//            } else {
//                print("No data return")
//            }
//        }
//    }
//
//    // URL에서 데이터 데이터를 가져오고, 디코딩 후 추가
//    func downloadData(fromURL url: URL, completionHandler: @escaping (_ data: Data?) -> ()) { // completionHandler는 이것이 끝나고 나서 다루겠다는 의미.
//        URLSession.shared.dataTask(with: url) { (data, response, error) in // 데이터, 응답, 오류
//            guard
//            let data = data, // 데이터 확인
//            error == nil, // 에러확인
//            let response = response as? HTTPURLResponse, // 응답 확인
//            response.statusCode >= 200 && response.statusCode < 300 else {
//                print("Error downloading data.")
//                completionHandler(nil) // 오류가 없으면 nil이 반환된다.
//                return
//            }
//
//            completionHandler(data) // 작업이 완료되었는지 확인하기 위해서도 필요
//
//        }.resume() // <- 시작기능
//
//        // 비동기적으로 지정된 URL에서 데이터를 다운로드하는 작업을 수행하는 함수
//        // 비동기적인 방식에서는 데이터 요청을 보낸 후에도 다음 동작을 계속해서 수행할 수 있습니다. 응답을 기다리지 않고, 백그라운드에서 데이터를 받아오는 동작을 수행할 수 있습니다. 이는 네트워크 요청이나 파일 다운로드 등 시간이 오래 걸릴 수 있는 작업을 수행할 때 유용합니다
//    }
//}
//
//struct DownloadWithEscapingBootcamp: View {
//
//    @StateObject var vm = DownloadWithEscapingViewModel()
//
//    var body: some View {
//        List {
//            ForEach(vm.posts) { post in // DownloadWithEscapingViewModel()의 posts를 바인딩
//                VStack(alignment: .leading) {
//                    Text(post.title)
//                        .font(.headline)
//                    Text(post.body)
//                        .foregroundColor(.gray)
//                }
//                .frame(maxWidth: .infinity, alignment: .leading)
//            }
//        }
//    }
//}
//
//struct DownloadWithEscapingBootcamp_Previews: PreviewProvider {
//    static var previews: some View {
//        DownloadWithEscapingBootcamp()
//    }
//}
