import SwiftUI

struct PlayPauseShape {
    private let barWidthFraction = CGFloat(11.0 / 34.0)

    private var isPlaying: Bool
    private var shift: CGFloat
}

// MARK: -
extension PlayPauseShape {
    init(isPlaying: Bool) {
        self.isPlaying = isPlaying
        shift = isPlaying ? 1 : 0
    }
}

// MARK: -
extension PlayPauseShape: Shape {
    // MARK: Shape
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let allPoints = pathPoints(
            width: rect.size.width,
            height: rect.size.height
        )

        for points in allPoints {
            guard let startPoint = points.first else { continue }

            path.move(to: startPoint)

            for i in 1..<points.count {
                let point = points[i]
                path.addLine(to: point)
            }

            path.closeSubpath()
        }

        return path
    }

    // MARK: Animatable
    public var animatableData: CGFloat {
        get { shift }
        set { shift = newValue }
    }
}

// MARK: -
private extension PlayPauseShape {
    func pathPoints(width: CGFloat, height: CGFloat) -> [[CGPoint]] {
        let pauseBarWidth = width * barWidthFraction

        var left: [CGPoint] = []
        var right: [CGPoint] = []
        var points: [[CGPoint]] = [[]]

        let m = (height * 0.5) / width
        let centerY = (width * 0.5 * m) - (height * 0.5)

        let leftPauseTopLeft = CGPoint(x: ((width * 0.5) - pauseBarWidth) * 0.5, y: 0)
        let leftPlayTopLeft = CGPoint.zero
        let leftDeltaTopLeft = leftPauseTopLeft - leftPlayTopLeft
        left.append(leftPlayTopLeft + (leftDeltaTopLeft * shift))

        let leftPauseTopRight = CGPoint(x:leftPauseTopLeft.x + pauseBarWidth, y: 0)
        let leftPlayTopRight = CGPoint(x: width * 0.5, y: -centerY)
        let leftDeltaTopRight = leftPlayTopRight - leftPauseTopRight
        left.append(leftPlayTopRight - (leftDeltaTopRight * shift))

        let leftPauseBottomRight = CGPoint(x: leftPauseTopRight.x, y: height)
        let leftPlayBottomRight = CGPoint(x: width * 0.5, y: height + centerY)
        let leftDeltaBottomRight = leftPlayBottomRight - leftPauseBottomRight
        left.append(leftPlayBottomRight - (leftDeltaBottomRight * shift))

        let leftPauseBottomLeft = CGPoint(x: (width * 0.5 - pauseBarWidth) * 0.5, y: height)
        let leftPlayBottomLeft = CGPoint(x: 0, y: height)
        let leftDeltaBottomLeft = leftPlayBottomLeft - leftPauseBottomLeft
        left.append(leftPlayBottomLeft - (leftDeltaBottomLeft * shift))

        points.append(left)

        let rightPauseTopLeft = CGPoint(x: leftPauseTopLeft.x + width * 0.5, y: leftPauseTopLeft.y)
        let rightPlayTopLeft = CGPoint(x: width * 0.5, y: -centerY)
        let rightDeltaTopLeft = rightPlayTopLeft - rightPauseTopLeft
        right.append(rightPlayTopLeft - (rightDeltaTopLeft * shift))

        let rightPauseTopRight = CGPoint(x: rightPauseTopLeft.x + pauseBarWidth, y: rightPauseTopLeft.y)
        let rightPlayTopRight = CGPoint(x: width, y: height * 0.5)
        let rightDeltaTopRight = rightPlayTopRight - rightPauseTopRight
        right.append(rightPlayTopRight - (rightDeltaTopRight * shift))

        let rightPauseBottomRight = CGPoint(x: rightPauseTopRight.x, y: height)
        let rightPlayBottomRight = rightPlayTopRight
        let rightDeltaBottomRight = rightPlayBottomRight - rightPauseBottomRight
        right.append(rightPlayBottomRight - (rightDeltaBottomRight * shift))

        let rightPauseBottomLeft = CGPoint(x: rightPauseTopLeft.x, y: height)
        let rightPlayBottomLeft = CGPoint(x: rightPlayTopLeft.x, y: height + centerY)
        let rightDeltaBottomLeft = rightPlayBottomLeft - rightPauseBottomLeft
        right.append(rightPlayBottomLeft - (rightDeltaBottomLeft * shift))

        points.append(right)

        return points
    }
}

// MARK: -
private extension CGPoint {
    static func *(left: CGPoint, scalar: CGFloat) -> CGPoint {
        .init(
            x: left.x * scalar,
            y: left.y * scalar
        )
    }

    static func *(scalar: CGFloat, right: CGPoint) -> CGPoint {
        .init(
            x: right.x * scalar,
            y: right.y * scalar
        )
    }

    static func +(left: CGPoint, right: CGPoint) -> CGPoint {
        .init(
            x: left.x + right.x,
            y: left.y + right.y
        )
    }

    static func -(left: CGPoint, right: CGPoint) -> CGPoint {
        .init(
            x: left.x - right.x,
            y: left.y - right.y
        )
    }
}
