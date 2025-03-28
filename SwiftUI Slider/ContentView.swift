//
//  ContentView.swift
//  SwiftUI Slider
//
//  Created by Дмитрий Богданов on 24.03.2025.
//

import SwiftUI

struct ContentView: View {
    
    @State var Value: CGFloat = 50
    @State var currentValue: CGFloat = 40
    @State var optimalValue: CGFloat = 75
    let minValue: CGFloat = 0
    let maxValue: CGFloat = 100
    
    var body: some View {
        ZStack{
            Color(.back).ignoresSafeArea(.all)
            VStack(spacing: 20) {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                    .padding(.bottom,75)
                
                
                TOEasySlider(value: $Value)
                
                TOAdvancedSlider(optimalValue: $optimalValue, currentValue: currentValue, minValue: minValue, maxValue: maxValue)
                
            }
            .padding()
        }
    }
}

#Preview {
    ContentView()
}
