import SpriteKit
import SwiftUI

class BoxGame: SKScene {
    var ball: SKShapeNode = SKShapeNode(circleOfRadius: 20)
    var copo1: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 60, height: 120))
    var copo2: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 60, height: 120))
    var copo3: SKShapeNode = SKShapeNode(rectOf: CGSize(width: 60, height: 120))
    var count: Double = 0
    var gaming: Int = 0
    lazy var valor: CGFloat = self.frame.width / 4
    lazy var pointer0: Bool = false
    lazy var pointer1: Bool = true
    lazy var pointer2: Bool = false

    override func didMove(to view: SKView){
        backgroundColor = .black
        setup()
        addElements()
    }

    func start() {
        if self.gaming == 0 {
            self.gaming = 1
            self.run(
                self.randomAnimations(interations: 12)
            )
        }
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        start()
    }

    func setupBall() {
        ball.fillColor = .cyan
        ball.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2)
    }

    func randomAnimations(interations: Int) -> SKAction {
        let lista = [change1(time: 0.30), change2(time: 0.30), change3(time: 0.30)]

        var actions: [SKAction] = []
        actions.append(copoDown(time: 1))
        actions.append(SKAction.wait(forDuration: 1))
        for _ in 0...interations {
            actions.append(lista.randomElement()!)
            actions.append(SKAction.wait(forDuration: 0.25))
        }
        actions.append(SKAction.wait(forDuration: 0.25))
        actions.append(copoUp(time: 0.25))
        let result = SKAction.sequence(actions)
        return result
    }

    func resultPositionBall() -> CGPoint {
        if pointer0 {
            return CGPoint(x: (self.frame.width / 4) * 1, y: self.frame.height / 2)
        } else if pointer1 {
            return CGPoint(x: (self.frame.width / 4) * 2, y: self.frame.height / 2)
        } else if pointer2 {
            return CGPoint(x: (self.frame.width / 4) * 3, y: self.frame.height / 2)
        } else {
            return CGPoint(x: self.frame.width / 2, y: (self.frame.width / 4) * 3)
        }
    }

    func setupCopo1() {
        copo1.position = CGPoint(x: (self.frame.width / 4) * 1, y: self.frame.height * 0.8)
        copo1.fillColor = .black
    }


    func setupCopo2() {
        copo2.position = CGPoint(x: (self.frame.width / 4) * 2, y: self.frame.height * 0.8)
        copo2.fillColor = .black
    }

    func setupCopo3() {
        copo3.position = CGPoint(x: (self.frame.width / 4) * 3, y: self.frame.height * 0.8)
        copo3.fillColor = .black
    }

    func addElements() {
        self.addChild(ball)
        self.addChild(copo1)
        self.addChild(copo2)
        self.addChild(copo3)
    }


    func setup() {
        setupBall()
        setupCopo1()
        setupCopo2()
        setupCopo3()
    }

    func copoDown(time: Double) -> SKAction {
        return SKAction.run {
            self.copo1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * -0.3) , duration: time))
            self.copo2.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * -0.3) , duration: time))
            self.copo3.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * -0.3) , duration: time)){ [self] in
                self.ball.position = CGPoint(x: -10, y: -10)
            }
        }
    }

    func copoUp(time: Double) -> SKAction {
        return SKAction.run {
            self.ball.position = self.resultPositionBall()
            self.copo1.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.3), duration: time))
            self.copo2.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.3), duration: time))
            self.copo3.run(SKAction.move(by: CGVector(dx: 0, dy: self.frame.size.height * 0.3), duration: time)){ [self] in
                self.gaming = 0
            }
        }
    }

    func change1(time: Double) -> SKAction{
        return SKAction.run {
            self.copo1.run(Animation.leftByRightOnePosition.move(time: time, valor: self.valor))
            self.copo1.run(Animation.contract.move(time: time))
            self.copo2.run(Animation.rightByLeftOnePosition.move(time: time, valor: self.valor)){ [self] in
                self.revesChange1()
                swap(&pointer0, &pointer1)
            }
        }
    }

    func revesChange1() {
        self.copo1.run(Animation.leftByRightOnePosition.move(time: 0, valor: self.valor).reversed())
        self.copo2.run(Animation.rightByLeftOnePosition.move(time: 0, valor: self.valor).reversed())
    }

    func change2(time: Double) -> SKAction {
        return SKAction.run {
            self.copo1.run(Animation.leftByRightTwoPositions.move(time: time, valor: self.valor))
            self.copo1.run(Animation.contract.move(time: time))
            self.copo3.run(Animation.expand.move(time: time))
            self.copo3.run(Animation.rightByLeftTwoPositions.move(time: time, valor: self.valor)){
                [self] in
                self.revesChange2()
                swap(&pointer0, &pointer2)
            }
        }
    }

    func revesChange2() {
        self.copo1.run(Animation.leftByRightTwoPositions.move(time: 0, valor: self.valor).reversed())
        self.copo3.run(Animation.rightByLeftTwoPositions.move(time: 0, valor: self.valor).reversed())
    }

    func change3(time: Double) -> SKAction{
        return SKAction.run {
            self.copo2.run(Animation.leftByRightOnePosition.move(time: time, valor: self.valor))
            self.copo2.run(Animation.contract.move(time: time))
            self.copo3.run(Animation.expand.move(time: time))
            self.copo3.run(Animation.rightByLeftOnePosition.move(time: time, valor: self.valor)){
                [self] in
                self.revesChange3()
                swap(&pointer1, &pointer2)
            }
        }
    }

    func revesChange3() {
        self.copo2.run(Animation.leftByRightOnePosition.move(time: 0, valor: self.valor).reversed())
        self.copo3.run(Animation.rightByLeftOnePosition.move(time: 0, valor: self.valor).reversed())
    }
}

        // move 1 1 pelo 2
        // move 2 1 pelo 3
        // move 3 2 pelo 3
        // move 4 da esquerda diminui e depois retorna
        // move 5 da direita aumenta
        // 3 variaveis



