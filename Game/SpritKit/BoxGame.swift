import SpriteKit
import SwiftUI

class BoxGame: SKScene {
    public var ball: SKShapeNode = SKShapeNode(circleOfRadius: 20)
    var door1: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 60, height: 120))
    var door2: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 60, height: 120))
    var door3: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 60, height: 120))

    lazy var displacementX: CGFloat = self.frame.width / 4
    var count: Double = 0
    var inAnimation: Bool = false

    lazy var pointer0: Bool = false
    lazy var pointer1: Bool = true
    lazy var pointer2: Bool = false

    lazy var door1Open: Bool = false
    lazy var door2Open: Bool = false
    lazy var door3Open: Bool = false

    var myChoice: Int = 0
    var victoriesStay: Int = 0


    override func didMove(to view: SKView){
        backgroundColor = .black
        setup()
        addElements()
    }

//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        start()
//    }


    func resultPositionBall() -> CGPoint {
        if pointer0 {
            return CGPoint(x: (self.frame.width / 4) * 1, y: self.frame.height * 0.75)
        } else if pointer1 {
            return CGPoint(x: (self.frame.width / 4) * 2, y: self.frame.height * 0.75)
        } else if pointer2 {
            return CGPoint(x: (self.frame.width / 4) * 3, y: self.frame.height * 0.75)
        } else {
            return CGPoint(x: self.frame.width / 2, y: (self.frame.width / 4) * 3)
        }
    }

    func addElements() {
        self.addChild(ball)
        self.addChild(door1)
        self.addChild(door2)
        self.addChild(door3)
    }

    func doorUp(time: Double) -> SKAction {
        return SKAction.run {
            self.ball.position = self.resultPositionBall()
            self.door1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.3), duration: time))
            self.door2.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.3), duration: time))
            self.door3.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.3), duration: time))
        }
    }

    func doorDown(time: Double) -> SKAction {
        return SKAction.run {
            self.door1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * -0.3) , duration: time))
            self.door2.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * -0.3) , duration: time))
            self.door3.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * -0.3) , duration: time))
        }
    }
}

extension BoxGame {
    func start() {
        if !self.inAnimation {
            self.inAnimation = true
            self.run(
                self.randomAnimations(interations: 12)
            ) {
                self.inAnimation = false
            }
        }
    }

    func chooseDoor1() {
        if ![door1Open, door2Open, door3Open].contains(true) && !inAnimation {
            inAnimation = true
            myChoice = 0
            door1.fillColor = .green
            door2.fillColor = .clear
            door3.fillColor = .clear
            revealOneDoor()
        }
    }

    func chooseDoor2() {
        if ![door1Open, door2Open, door3Open].contains(true) {
            myChoice = 1
            door2.fillColor = .green
            door1.fillColor = .clear
            door3.fillColor = .clear
            revealOneDoor()
        }
    }

    func chooseDoor3() {
        if ![door1Open, door2Open, door3Open].contains(true) {
            myChoice = 2
            door3.fillColor = .green
            door1.fillColor = .clear
            door2.fillColor = .clear
            revealOneDoor()
        }
    }

    func revealOneDoor() {
        var pointers = [(pointer0, door1, 0),
                        (pointer1, door2, 1),
                        (pointer2, door3, 2)]
        let myDoor = pointers[myChoice]
        pointers.remove(at: myChoice)
        if myDoor.0 == true {
            pointers.remove(at: [0, 1].randomElement()!)
        } else {
            if pointers[0].0 == true {
                pointers.remove(at: 0)
            } else {
                pointers.remove(at: 1)
            }
        }

        pointers[0].1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1)) {
            switch pointers[0].2 {
            case 0:
                self.door1Open = true
            case 1:
                self.door2Open = true
            case 2:
                self.door3Open = true
            default:
                return
            }
            self.inAnimation = false
        }
    }

    func stayWithDoor() {
        let pointers = [pointer0, pointer1, pointer2]
        if pointers[myChoice] {
            victoriesStay += 1
        }
        openTwoDoors()
    }

    private func openTwoDoors() {
        if door1Open {
            self.door2.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1))
            self.door3.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1))
        } else if (door2Open) {
            door1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1))
            door3.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1))
        } else if (door3Open) {
            door1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1))
            door2.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.05), duration: 1)) {
            }
        }
        self.ball.position = self.resultPositionBall()
    }

    func changeDoor() {
        self.setup()
    }
}

extension BoxGame {
    func setup() {
        setupDoor1()
        setupDoor2()
        setupDoor3()
        let point = [0, 1, 2].randomElement()
        switch point {
        case 0:
            pointer0 = true
            pointer1 = false
            pointer2 = false
        case 1:
            pointer0 = false
            pointer1 = true
            pointer2 = false
        case 2:
            pointer0 = false
            pointer1 = false
            pointer2 = true
        default:
            return
        }
        door1Open = false
        door2Open = false
        door3Open = false
    }

    func setupBall() {
        ball.fillColor = .cyan
        ball.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    }

    func setupDoor1() {
        door1.position = CGPoint(x: (self.frame.width / 4) * 1, y: self.frame.height * 0.8)
        door1.fillColor = .black
    }

    func setupDoor2() {
        door2.position = CGPoint(x: (self.frame.width / 4) * 2, y: self.frame.height * 0.8)
        door2.fillColor = .black
    }

    func setupDoor3() {
        door3.position = CGPoint(x: (self.frame.width / 4) * 3, y: self.frame.height * 0.8)
        door3.fillColor = .black
    }
}

extension BoxGame {
    func randomAnimations(interations: Int) -> SKAction {
        let lista = [change1(time: 0.30), change2(time: 0.30), change3(time: 0.30)]

        var actions: [SKAction] = []
        actions.append(doorDown(time: 1))
        actions.append(SKAction.wait(forDuration: 1))
        for _ in 0...interations {
            actions.append(lista.randomElement()!)
            actions.append(SKAction.wait(forDuration: 0.25))
        }
        actions.append(SKAction.wait(forDuration: 0.25))
//        actions.append(doorUp(time: 0.25))
        let result = SKAction.sequence(actions)
        return result
    }

    func change1(time: Double) -> SKAction {
        return SKAction.run {
            self.door1.run(Animation.leftByRightOnePosition.move(time: time, displacementX: self.displacementX))
            self.door1.run(Animation.contract.move(time: time))
            self.door2.run(Animation.rightByLeftOnePosition.move(time: time, displacementX: self.displacementX)){ [self] in
                self.revesChange1()
                swap(&pointer0, &pointer1)
            }
        }
    }

    func revesChange1() {
        self.door1.run(Animation.leftByRightOnePosition.move(time: 0, displacementX: self.displacementX).reversed())
        self.door2.run(Animation.rightByLeftOnePosition.move(time: 0, displacementX: self.displacementX).reversed())
    }

    func change2(time: Double) -> SKAction {
        return SKAction.run {
            self.door1.run(Animation.leftByRightTwoPositions.move(time: time, displacementX: self.displacementX))
            self.door1.run(Animation.contract.move(time: time))
            self.door3.run(Animation.expand.move(time: time))
            self.door3.run(Animation.rightByLeftTwoPositions.move(time: time, displacementX: self.displacementX)){
                [self] in
                self.revesChange2()
                swap(&pointer0, &pointer2)
            }
        }
    }

    func revesChange2() {
        self.door1.run(Animation.leftByRightTwoPositions.move(time: 0, displacementX: self.displacementX).reversed())
        self.door3.run(Animation.rightByLeftTwoPositions.move(time: 0, displacementX: self.displacementX).reversed())
    }

    func change3(time: Double) -> SKAction{
        return SKAction.run {
            self.door2.run(Animation.leftByRightOnePosition.move(time: time, displacementX: self.displacementX))
            self.door2.run(Animation.contract.move(time: time))
            self.door3.run(Animation.expand.move(time: time))
            self.door3.run(Animation.rightByLeftOnePosition.move(time: time, displacementX: self.displacementX)){
                [self] in
                self.revesChange3()
                swap(&pointer1, &pointer2)
            }
        }
    }

    func revesChange3() {
        self.door2.run(Animation.leftByRightOnePosition.move(time: 0, displacementX: self.displacementX).reversed())
        self.door3.run(Animation.rightByLeftOnePosition.move(time: 0, displacementX: self.displacementX).reversed())
    }
}

