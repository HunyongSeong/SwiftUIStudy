//
//  AsyncImageBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/05/25.
//

import SwiftUI
// AsyncImage: 비동기 이미지

/*
 case empty -> No image is loaded.
 case success(Image) -> An image succesfully loaded.
 case failure(Error) -> An image failed to load with an error.
 */

struct AsyncImageBootcamp: View {
    
    let url = URL(string: "https://picsum.photos/400")
    
    var body: some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .empty:
                ProgressView()
            case .success(let returnedImage):
                returnedImage
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .cornerRadius(20)
            case .failure:
                Image(systemName: "questionmark")
                    .font(.headline)
            default:
                Image(systemName: "questionmark")
                    .font(.headline)
            }
        }
//        AsyncImage(url: url, content: { returnedImage in
//            returnedImage
//                .resizable()
//                .scaledToFit()
//                .frame(width: 100, height: 100)
//                .cornerRadius(20)
//        }, placeholder: {
//            ProgressView()
//        })
    }
}

struct AsyncImageBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImageBootcamp()
    }
}
