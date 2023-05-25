//
//  BackgroundMaterialsBootcamp.swift
//  SwiftUIBootcamp
//
//  Created by David Goggins on 2023/05/25.
//

import SwiftUI

struct BackgroundMaterialsBootcamp: View {
    var body: some View {
        VStack {
            Spacer()
            
            VStack {
                RoundedRectangle(cornerRadius: 4)
                    .frame(width: 50, height: 4)
                    .padding()
                Spacer()
            }
            .frame(height: 350)
            .frame(maxWidth: .infinity)
//            .background(Color.white.opacity(0.5)) // iOS 15에서 사용 가능
//            .background(.thinMaterial)
//            .background(.thickMaterial)
            .background(.regularMaterial)
//            .background(.ultraThinMaterial)
//            .background(.ultraThickMaterial)
            .cornerRadius(30)
        }
        .ignoresSafeArea()
        .background(
            Image("jaypark")
        )
    }
}

struct BackgroundMaterialsBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundMaterialsBootcamp()
    }
}
