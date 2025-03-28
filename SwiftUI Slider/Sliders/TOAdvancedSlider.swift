//
//  TOAdvancedSlider.swift
//  SwiftUI Slider
//
//  Created by Дмитрий Богданов on 24.03.2025.
//

import SwiftUI

struct TOAdvancedSlider: View {
    // MARK: - Bindings and State
    @Binding var optimalValue: CGFloat
    @State var currentValue: CGFloat
    @State private var sliderOffset: CGFloat = 0
    @State private var backgroundOffset: CGFloat = 0
    @State private var indicatorOffset: CGFloat = 0
    @State private var isBoosted: Bool = false

    // MARK: - Constants
    let minValue: CGFloat
    let maxValue: CGFloat
    private let customRed = Color(red: 1, green: 99/255, blue: 78/255)
    private let customBlue = Color(red: 83/255, green: 152/255, blue: 1)
    private let gradientColors = [
        Color(red: 134/255, green: 229/255, blue: 245/255),
        Color(red: 1, green: 192/255, blue: 0),
        Color(red: 1, green: 158/255, blue: 88/255),
        Color(red: 1, green: 99/255, blue: 78/255)
    ]

    var body: some View {
        VStack {
            // MARK: - Indicator
            RoundedTriangle(cornerRadius: 1.7, corners: .all)
                .fill(currentValue > optimalValue ? customBlue : customRed)
                .animation(.linear(duration: 0.2))
                .rotationEffect(.degrees(180), anchor: .center)
                .frame(width: 10, height: 7)
                .offset(x: indicatorOffset)

            // MARK: - Slider Body
            ZStack {
                // Background Border
                RoundedRectangle(cornerRadius: 10)
                    .foregroundStyle(.border)
                    .frame(height: 50)

                // Gradient and Mask
                GeometryReader { reader in
                    let width = reader.size.width

                    ZStack {
                        // Striped Overlay
                        StripedOverlay(
                            shape: RoundedRectangle(cornerRadius: 10),
                            angle: 30,
                            style: currentValue > optimalValue ? .gray : customRed,
                            lineWidth: 3
                        )
                        .frame(height: 50)
                        .offset(x: currentValue > optimalValue ? calculateOffset(width: width, value: currentValue, inverse: true) : backgroundOffset)

                        // Gradient Mask
                        LinearGradient(colors: currentValue > optimalValue ? [customBlue] : gradientColors, startPoint: .topLeading, endPoint: .bottomTrailing)
                            .animation(.linear(duration: 0.3))
                            .frame(height: 50)
                            .mask(
                                RoundedRectangle(cornerRadius: 10)
                                    .frame(height: 50)
                                    .offset(x: currentValue > optimalValue ? backgroundOffset : calculateOffset(width: width, value: currentValue, inverse: true))
                            )
                    }
                    .onAppear {
                        backgroundOffset = calculateOffset(width: width, value: optimalValue, inverse: true)
                    }
                    .onChange(of: optimalValue) {
                        backgroundOffset = calculateOffset(width: width, value: optimalValue, inverse: true)
                    }
                }
                .frame(height: 50)

                // Slider Handle
                GeometryReader { reader in
                    let width = reader.size.width

                    Rectangle()
                        .fill(currentValue > optimalValue ? Color.white : customRed)
                        .animation(.linear(duration: 0.2), value: currentValue > optimalValue)
                        .frame(width: 5, height: 35)
                        .cornerRadius(15)
                        .offset(x: sliderOffset.clamped(to: 8...width - 8))
                        .gesture(
                            DragGesture()
                                .onChanged { gesture in
                                    let newValue = (gesture.location.x / width * 100).clamped(to: minValue...maxValue)
                                    optimalValue = newValue
                                    sliderOffset = calculateOffset(width: width, value: newValue)
                                }
                        )
                        .onAppear {
                            sliderOffset = calculateOffset(width: width, value: optimalValue)
                        }
                }
                .frame(height: 35)
            }
            .addBorder(Color.border, width: 1.1, cornerRadius: 10)
            .foregroundStyle(.white)

            HStack{
                Text("\(Int(minValue))°")
                    .foregroundStyle(.gray)
                Spacer()
                Text("\(Int(maxValue))°")
                    .foregroundStyle(.gray)
            }
            
            // MARK: - Stepper
            Stepper("Current Value: \(Int(currentValue))", value: $currentValue, in: minValue...maxValue, step: 5)
                .colorInvert()
                .padding(.top,20)
        }
    }

    // MARK: - Helper Functions
    private func calculateOffset(width: CGFloat, value: CGFloat, inverse: Bool = false) -> CGFloat {
        indicatorOffset = width * (value / 100) - width / 2
        return inverse ? -width + (value / 100) * width : (value / 100) * width - 15
    }
    
}
extension CGFloat {
    /// Ограничивает значение внутри указанного диапазона.
    func clamped(to range: ClosedRange<CGFloat>) -> CGFloat {
        Swift.min(Swift.max(self, range.lowerBound), range.upperBound)
    }
}





#Preview {
    ContentView()
}
