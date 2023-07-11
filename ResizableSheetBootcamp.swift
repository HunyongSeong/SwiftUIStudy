//
//  ResizableSheetBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/07/11.
//

import SwiftUI

struct ResizableSheetBootcamp: View {
    
    @State private var showSheet: Bool = false
    @State private var detents: PresentationDetent = .large
    
    var body: some View {
        Button("Click me") {
            showSheet.toggle()
        }
        .sheet(isPresented: $showSheet) {
            MyNextView(detents: $detents)
//                .presentationDetents([.fraction(0.1), .medium, .large])
//                .presentationDetents([.medium, .large]) // large, medium
//                .presentationDetents([.height(200)]) // 높이
//                .presentationDetents([.medium, .large, .fraction(0.2)], selection: $detents)
            //presentationDetents 에서 설정한 [.medium, .large, .fraction(0.2)]이것만 detents로 설정할 수 있음
//                .presentationDragIndicator(.hidden) //
//                .interactiveDismissDisabled()
        }
        .onAppear {
            showSheet = true
        }
    }
}

struct MyNextView: View {
    // 자체적으로 사용자 바인딩을 만들 수 있다는 것이 멋지다
    @Binding var detents: PresentationDetent
    
    var body: some View {
        ZStack {
            Color.red.ignoresSafeArea()
            
            VStack(spacing: 20) {
                
                Button("20%") {
                    detents = .fraction(0.2)
                }
                
                Button("MEDIUM") {
                    detents = .medium
                }
                
                Button("600px") {
                    detents = .height(600)
                }
                
                Button("LARGE") {
                    detents = .large
                }
            }
        }
        .presentationDetents([.medium, .large, .fraction(0.2), .height(600)], selection: $detents)
        .presentationDragIndicator(.hidden) //

    }
}

struct ResizableSheetBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ResizableSheetBootcamp()
    }
}
