//
//  DownloadWithCombineBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/21.
//

import SwiftUI
import Combine

struct PostModel: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

class DownloadWithCombineViewModel: ObservableObject {
    
    @Published var posts: [PostModel] = []
    var cancellables = Set<AnyCancellable>() // publisher 저장하고 나중에 취소하려는 경우 사용가능
    
    init() {
        getPosts()
    }
    
    func getPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return }
        
        // 월간구독 패키지 (우리가 작성하려고 하는 코드의 이해)
        // 1 패키지에 가입하면 월간 구독에 가입한다.
        // 2 회사는 보이지 않는 곳에서 패키지를 만든다
        // 3 우리의 문앞으로 패송한다
        // 4 손상이 없는지 확인한다
        // 5 항목이 올바른지 확인한다
        // 6 아이템을 사용한다
        // 7 언제든지 취소할 수 있다
        
        // 1 출판사 생성 - 구독 가입
        // 2 작업을 백그라운드 큐에서 실행하도록 지정합니다.
        // 3 메인쓰레드에서 받는다
        // 4 map을 시도하여 데이터가 양호한지 확인 (http url응답이고 양호한지)
        // 5 올바르게 포스트모델의 배열로 디코딩 하였는지 확인
        // 6 동기화하면 앱에 항목이 추가된다
        // 7 store / 필요하다면 취소한다

        URLSession.shared.dataTaskPublisher(for: url) //(1)
//            .subscribe(on: DispatchQueue.global(qos: .background)) //(2)
            .receive(on: DispatchQueue.main) //(3) // 없앨 시 (**)에 백그라운드에 있지 않아야 한다고 알려줌 / 메인에서 그려줘야 함
        
        
            //추가 ++ ==========================================================
//            .tryMap(handleOutput) // 추가하면서 생긴..
            // ================================================================
        
        
            .tryMap { (data, response) -> Data in //(4)
                guard
                    let response = response as? HTTPURLResponse,
                    response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse) // <- 에러
                }
                return data // 이상이 없다면 데이터 반환
            }
        
        
            .decode(type: [PostModel].self, decoder: JSONDecoder()) //(5)
            .sink { (completion) in //(6) 포스트 모델이 배열인것을 받는다.
                print("complition: \(completion)") // 오류가 있는지 알려준다
            } receiveValue: { [weak self](returnedPosts) in
                self?.posts = returnedPosts //(**) 이상이 없다면, 빈 posts 배열에 포스트 모델을 받는다.
            }
            .store(in: &cancellables) //(7)

    }
    
    
    // 추가 ++ (1) ==========================================================
//    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
//        guard
//            let response = output.response as? HTTPURLResponse,
//            response.statusCode >= 200 && response.statusCode < 300 else {
//            throw URLError(.badServerResponse) // <- 에러
//        }
//        return output.data // 이상이 없다면 데이터 반환
//    }
    //==================================================================
    
    
}

struct DownloadWithCombineBootcamp: View {
    
    @StateObject var vm = DownloadWithCombineViewModel()
    
    var body: some View {
        List {
            ForEach(vm.posts) { post in
                VStack {
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

struct DownloadWithCombineBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        DownloadWithCombineBootcamp()
    }
}
