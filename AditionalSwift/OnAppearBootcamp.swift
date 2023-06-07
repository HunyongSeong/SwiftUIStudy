//
//  SwiftUIView.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/06/06.
//

import SwiftUI

struct OnAppearBootcamp: View {
    @State var title: String = "안녕하세요"
    var body: some View {
        NavigationView {
            ScrollView {
                Text(title)
            }
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    title = "서근개발블로그"
                }
            })
            .navigationBarTitle("onAppear Bootcamp")
        }
    }
}

struct OnAppearBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        OnAppearBootcamp()
    }
}
