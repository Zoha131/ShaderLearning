//
//  ContentView.swift
//  ShaderLearning
//
//  Created by MD Abir Hasan Zoha on 9/22/23.
//

import SwiftUI

struct ContentView: View {
    let startDate = Date()
    
    var body: some View {
        GeometryReader { proxy in
            TimelineView(.animation) { timeInfo in
                let time = timeInfo.date.timeIntervalSince1970 - startDate.timeIntervalSince1970
                
                Color.red
                    .colorEffect(
                        .init(
                            function: .init(library: .default, name: "pattern"),
                            arguments: [.float2(proxy.size.width, proxy.size.height), .float(time)]
                        )
                    )
                    .ignoresSafeArea()
            }
        }

    }
}

#Preview {
    ContentView()
}
