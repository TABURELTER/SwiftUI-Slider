//
//  RoundedTriangle.swift
//  SwiftUI Slider
//
//  Created by Дмитрий Богданов on 24.03.2025.
//


import SwiftUI

struct TOEasySlider: View {
    
    @Binding var value: CGFloat
    
    @State private var sliderOffset: CGFloat = 0
    @State private var backgroundOffset: CGFloat = 0
    
    private let sliderHeight: CGFloat = 50
    private let thumbWidth: CGFloat = 5
    private let thumbHeight: CGFloat = 35
    private let markerSpacing: CGFloat = 25
    private let thumbOffsetAdjustment: CGFloat = 8  // Small adjustment for the thumb

    var body: some View {
        ZStack {
            sliderBackground
            valueMarkers
            draggableThumb
        }
        .addBorder(Color.border, width: 1.1, cornerRadius: 10)
        .foregroundStyle(.white)
    }
    
    private var sliderBackground: some View {
        GeometryReader { reader in
            let width = reader.size.width
            Rectangle()
                .foregroundStyle(.sliderback)
                .cornerRadius(10)
                .frame(height: sliderHeight)
                .offset(x: backgroundOffset)
                .onChange(of: value) {
                    backgroundOffset = calculateOffset(for: value, in: width)
                }
                .onAppear {
                    backgroundOffset = calculateOffset(for: value, in: width)
                }
        }
        .frame(height: sliderHeight)
    }
    
    private var valueMarkers: some View {
        HStack(spacing: markerSpacing) {
            ForEach(Array(0...4).map { $0 * 25 }, id: \.self) { markerValue in
                Text("\(markerValue)")
                    .font(.custom("Mulish", size: 18).bold())
                if markerValue != 100 {
                    Rectangle().frame(width: 1.5, height: 12)
                }
            }
        }
        .frame(alignment: .center)
    }
    
    private var draggableThumb: some View {
        GeometryReader { reader in
            let width = reader.size.width
            Rectangle()
                .foregroundStyle(.white)
                .frame(width: thumbWidth, height: thumbHeight)
                .cornerRadius(15)
                .offset(x: sliderOffset < thumbOffsetAdjustment + 2 ? thumbOffsetAdjustment + 2 : sliderOffset > width - thumbWidth - thumbOffsetAdjustment ? width - thumbWidth - thumbOffsetAdjustment : sliderOffset)
                .gesture(
                    DragGesture()
                        .onChanged { gesture in
                            let newValue = min(max(0, gesture.location.x / width * 100), 100)
                            value = newValue
                            sliderOffset = calculateSliderOffset(for: newValue, in: width)
                        }
                )
                .onAppear {
                    sliderOffset = calculateSliderOffset(for: value, in: width)
                }
        }
        .frame(height: thumbHeight)
    }
    
    private func calculateOffset(for value: CGFloat, in width: CGFloat) -> CGFloat {
        -width + (value / 100) * width
    }
    
    private func calculateSliderOffset(for value: CGFloat, in width: CGFloat) -> CGFloat {
        ((value / 100) * width - thumbWidth / 2) - 15
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    ContentView()
}

#Preview(traits: .sizeThatFitsLayout) {
    @Previewable @State var currentValue: CGFloat = 50
    TOEasySlider(value: $currentValue)
}

extension View {
    public func addBorder<S>(_ content: S, width: CGFloat = 1, cornerRadius: CGFloat) -> some View where S: ShapeStyle {
        let roundedRect = RoundedRectangle(cornerRadius: cornerRadius)
        return clipShape(roundedRect)
            .overlay(roundedRect.strokeBorder(content, lineWidth: width))
    }
}
