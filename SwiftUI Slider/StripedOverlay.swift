//
//  StripedOverlay.swift
//  SwiftUI Slider
//
//  Created by Дмитрий Богданов on 25.03.2025.
//

import SwiftUI

struct StripedOverlay<S: Shape, T: ShapeStyle>: View {
    let shape: S // Любая фигура, соответствующая протоколу `Shape`
    let angle: Double // Угол линий (в градусах)
    let style: T // Цвет или градиент для линий
    let lineWidth: CGFloat // Толщина линий
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                
                shape.stroke(style, lineWidth: lineWidth)
                
                Path { path in
                    let stripeSpacing: CGFloat = 15 // Расстояние между линиями
                    let width = geometry.size.width
                    let height = geometry.size.height
                    let diagonal = sqrt(width * width + height * height)
                    
                    // Генерация линий
                    for offset in stride(from: -2 * diagonal, to: 2 * diagonal, by: stripeSpacing) {
                        let startX = offset
                        let startY = 0.0
                        let endX = offset - diagonal * tan(angle * .pi / 180)
                        let endY = diagonal
                        
                        path.move(to: CGPoint(x: startX, y: startY))
                        path.addLine(to: CGPoint(x: endX, y: endY))
                    }
                }
                .stroke(style, lineWidth: lineWidth) // Применение цвета или градиента
            }
            .mask(shape) // Используем переданную фигуру для ограничения
        }
    }
}
