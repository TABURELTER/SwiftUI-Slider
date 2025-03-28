//
//  RoundedTriangle.swift
//  SwiftUI Slider
//
//  Created by Дмитрий Богданов on 28.03.2025.
//


import SwiftUI

public struct RoundedTriangle: Shape {

    // MARK: Properties

    public let cornerRadius: CGFloat
    public let corners: Corners

    // MARK: Types

    public struct Corners: OptionSet, Sendable {
        public let rawValue: Int
        public init(rawValue: Int) { self.rawValue = rawValue }
        public static let top = Corners(rawValue: 1 << 0)
        public static let left = Corners(rawValue: 1 << 1)
        public static let right = Corners(rawValue: 1 << 2)
        public static let all: Corners = [.top, .left, .right]
    }

    // MARK: Init

    public init(cornerRadius: CGFloat = 8, corners: Corners = .all) {
        self.cornerRadius = cornerRadius
        self.corners = corners
    }

    // MARK: Path

    public func path(in rect: CGRect) -> Path {
        let minDimension = min(rect.width, rect.height)
        let adjustedCornerRadius = min(cornerRadius, minDimension / 2)

        let topRadius = corners.contains(.top) ? adjustedCornerRadius : 0
        let leftRadius = corners.contains(.left) ? adjustedCornerRadius : 0
        let rightRadius = corners.contains(.right) ? adjustedCornerRadius : 0

        let top = CGPoint(x: rect.midX, y: rect.minY + topRadius)
        let left = CGPoint(x: rect.minX + leftRadius, y: rect.maxY - leftRadius)
        let right = CGPoint(x: rect.maxX - rightRadius, y: rect.maxY - rightRadius)

        let topLeft = tangentAngle(c1: top, r1: topRadius, c2: left, r2: leftRadius)
        let leftRight = tangentAngle(c1: left, r1: leftRadius, c2: right, r2: rightRadius)
        let rightTop = tangentAngle(c1: right, r1: rightRadius, c2: top, r2: topRadius)

        return Path { path in
            if minDimension <= 2 * adjustedCornerRadius {
                path.addLines([top, left, right])
            } else {
                path.addArc(center: top, radius: topRadius, startAngle: rightTop, endAngle: topLeft, clockwise: true)
                path.addArc(center: left, radius: leftRadius, startAngle: topLeft, endAngle: leftRight, clockwise: true)
                path.addArc(center: right, radius: rightRadius, startAngle: leftRight, endAngle: rightTop, clockwise: true)
            }
            path.closeSubpath()
        }
    }

    // MARK: Helpers

    private func tangentAngle(c1: CGPoint, r1: CGFloat, c2: CGPoint, r2: CGFloat) -> Angle {
        let dx = c2.x - c1.x
        let dy = c2.y - c1.y
        let dist = sqrt(dx * dx + dy * dy)
        guard dist > abs(r1 - r2) else {
            return .zero
        }
        let theta = atan2(dy, dx)
        let phi = acos((r1 - r2) / dist)
        return .radians(theta + phi)
    }
}


#Preview {
    let size : CGFloat = 10
    ZStack {
        RoundedTriangle(cornerRadius: 1, corners: .all)
            .fill(Color.blue)
            .rotationEffect(.degrees(45),anchor: .center)
            
    }
    .frame(width: size, height: size)
    .background(Color.black.opacity(0.07))
}

