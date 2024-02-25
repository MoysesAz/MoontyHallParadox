import SpriteKit

enum Animation {
    func move(time: Double, displacementX: Double = 0) -> SKAction {
        switch self {
        case .leftByRightOnePosition:
            let result = SKAction.move(by: CGVector(dx: displacementX, dy: 0) , duration: time)
            return result
        case .leftByRightTwoPositions:
            let result = SKAction.move(by: CGVector(dx: displacementX * 2, dy: 0) , duration: time)
            return result
        case .rightByLeftOnePosition:
            let result = SKAction.move(by: CGVector(dx: -displacementX, dy: 0) , duration: time)
            return result
        case .rightByLeftTwoPositions:
            let result = SKAction.move(by: CGVector(dx: -displacementX * 2, dy: 0) , duration: time)
            return result
        case .contract:
            let move1 = SKAction.scale(by: 0.8, duration: time/2)
            let move2 = move1.reversed()
            let result = SKAction.sequence([move1, move2])
            return result
        case .expand:
            let move1 = SKAction.scale(by: 1.2, duration: time/2)
            let move2 = move1.reversed()
            return SKAction.sequence([move1, move2])
        }
    }

    case leftByRightOnePosition
    case leftByRightTwoPositions
    case rightByLeftOnePosition
    case rightByLeftTwoPositions
    case contract
    case expand
}
