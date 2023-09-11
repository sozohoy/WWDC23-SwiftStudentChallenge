
//
//  File.swift
//  
//
//  Created by 한지석 on 2023/04/11.
//

import SwiftUI
import SpriteKit

protocol GameSceneDelegate: AnyObject {
    func removeMicroPlasticNode()
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
//    let gameModel = GameModel()
    weak var gameDelegate: GameSceneDelegate?
    var limitedBounds: CGRect = CGRect.zero
    var basket: SKSpriteNode!
    var toggle = SKSpriteNode(imageNamed: "toggleOn")
//    var toggleOff = "toggleOff"
//    var toggleOn = "toggleOn"
//    var microPlastic: SKSpriteNode?
    var isCooldown = false
    var cooldownTime: TimeInterval = 0.5
    let plastics = ["plastic1", "plastic2", "plastic3", "plastic4", "plastic5", "plastic6", "plastic7", "plastic8", "plastic9", "plastic10"]
    var isOn = false
    @Binding var recycleCount: Int
    @Binding var touchCount: Int
    @Binding var completeIsPresented: Bool
    
    init(recycleCount: Binding<Int>,
         touchCount: Binding<Int>,
         completeIsPresented: Binding<Bool>) {
        self._recycleCount = recycleCount
        self._touchCount = touchCount
        self._completeIsPresented = completeIsPresented
        super.init(size: CGSize.zero)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        limitedBounds = CGRect(x: 0, y: size.height - 170, width: size.width, height: 170)
        backgroundSetting()
        microPlasticSetting()
        basketSetting()
        toggleSetting()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let nodeA = contact.bodyA.node
        let nodeB = contact.bodyB.node
        
//        // 플라스틱 노드가 떨어질 때, 바닥으로 떨어지게 하는 코드
//        print(physicsBody) // 무조건 배경
        if nodeA?.physicsBody == physicsBody {
            nodeB?.removeFromParent()
        } else if nodeB?.physicsBody == physicsBody {
            nodeA?.removeFromParent()
        }
        
        let A = Int(nodeB?.physicsBody?.categoryBitMask ?? 0)
        let B = Int(nodeA?.physicsBody?.categoryBitMask ?? 0)
        if (A + B == 3) {
            recycleCount += 1
            let plastic = nodeA == basket ? nodeB : nodeA
            plastic?.removeFromParent()
        }
    }  
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isCooldown else {
            print("CoolTime!")
            return }
        guard let touch = touches.first else { return }
        let location = touch.location(in: self)
        let touchedNode = atPoint(location)
        if touchedNode.name == "toggle" {
            toggleClicked()
        }
        print(children)
        if touchCount < 10 && limitedBounds.contains(location) {
            let plastic = SKSpriteNode(imageNamed: plastics[touchCount])
            plastic.name = "plastic"
            plastic.position = location
            plastic.physicsBody = SKPhysicsBody(rectangleOf: plastic.size)
            plastic.physicsBody?.categoryBitMask = 2
            plastic.physicsBody?.contactTestBitMask = 1
            addChild(plastic)
            touchCount += 1
            isCooldown = true
            DispatchQueue.main.asyncAfter(deadline: .now() + cooldownTime) { [weak self] in
                self?.isCooldown = false
            }
            if touchCount == 10 {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    self.completeIsPresented = true
                }
            }
        }
    }
    
    func backgroundSetting() {
        let startColor = UIColor(named: "background2")!.cgColor
        let endColor = UIColor(named: "background1")!.cgColor
        let backgroundImage: UIImage = UIImage.gradientImage(withBounds: self.frame,
                                                             startPoint: CGPoint(x: 0.5, y: 0),
                                                             endPoint: CGPoint(x: 0.5, y: 1),
                                                             colors: [startColor, endColor])
        let gradientTexture = SKTexture(image: backgroundImage)
        let background = SKSpriteNode(texture: gradientTexture)
        background.position = CGPoint(x: frame.midX, y: frame.midY)
        background.name = "background"
        addChild(background)
    }
    
    func microPlasticSetting() {
        let numberOfElements = 30
        var microNumber = 0
        for _ in 0..<numberOfElements / 2 {
            if microNumber >= 10 {
                microNumber = 0
            }
            let microPlastic = SKSpriteNode(imageNamed: "micro\(microNumber)")
//            let element = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 10))
            microPlastic.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(size.width))), y: CGFloat(arc4random_uniform(UInt32(size.height))))
            microPlastic.name = "microPlastic"
            // 랜덤한 방향으로 움직이는 SKAction을 만듭니다.
            let dx = CGFloat(arc4random_uniform(1000))-100 // -100 ~ 100 사이의 값을 랜덤하게 선택합니다.
            let dy = CGFloat(arc4random_uniform(1000))-100
            let firstAction = SKAction.moveBy(x: dx, y: dy, duration: 10.0)
            let secondAction = SKAction.moveBy(x: -dx, y: -dy, duration: 10.0)
            
            let sequence = SKAction.sequence([firstAction, secondAction])
            let moveForever = SKAction.repeatForever(sequence)
            microPlastic.run(moveForever)
            addChild(microPlastic)
            microNumber += 1
        }
        
        for _ in 0..<numberOfElements / 2 {
            if microNumber >= 10 {
                microNumber = 0
            }
            let microPlastic = SKSpriteNode(imageNamed: "micro\(microNumber)")
//            let element = SKSpriteNode(color: .black, size: CGSize(width: 10, height: 10))
            microPlastic.position = CGPoint(x: CGFloat(arc4random_uniform(UInt32(size.width))), y: CGFloat(arc4random_uniform(UInt32(size.height))))
            microPlastic.name = "microPlastic"
            // 랜덤한 방향으로 움직이는 SKAction을 만듭니다.
            let dx = CGFloat(arc4random_uniform(1000))-100 // -100 ~ 100 사이의 값을 랜덤하게 선택합니다.
            let dy = CGFloat(arc4random_uniform(1000))-100
            let firstAction = SKAction.moveBy(x: -dx, y: -dy, duration: 10.0)
            let secondAction = SKAction.moveBy(x: dx, y: dy, duration: 10.0)
            
            let sequence = SKAction.sequence([firstAction, secondAction])
            let moveForever = SKAction.repeatForever(sequence)
            microPlastic.run(moveForever)
            addChild(microPlastic)
            microNumber += 1
        }
    }
    
    func toggleSetting() {
//        let buttonTexture = SKTexture(imageNamed: "toggleOff")
        toggle.position = CGPoint(x: size.width - 50, y: 500)
        toggle.name = "toggle"
        addChild(toggle)
    }
    
    func basketSetting() { // categoryBitMask == 1
        basket = SKSpriteNode(imageNamed: "basket")
        // 바구니 위치
        basket.position = CGPoint(x: size.width / 2, y: 125)
        basket.name = "basket"
        addChild(basket)
        let moveLeft = SKAction.moveTo(x: 50, duration: 1.0)
        let moveRight = SKAction.moveTo(x: size.width - 50, duration: 1.0)
        let moveSequence = SKAction.sequence([moveLeft, moveRight])
        let moveForever = SKAction.repeatForever(moveSequence)
        basket.run(moveForever)
        basket.physicsBody = SKPhysicsBody(rectangleOf: basket.size)
        basket.physicsBody?.categoryBitMask = 1
        basket.physicsBody?.contactTestBitMask = 2
        basket.physicsBody?.affectedByGravity = false
        basket.physicsBody?.isDynamic = false
        physicsWorld.contactDelegate = self
    }
    
    func toggleClicked() {
        isOn.toggle()
        if isOn {
            removeMicroPlasticNode()
            toggle.texture = SKTexture(imageNamed: "toggleOff")
        } else {
            microPlasticSetting()
            toggle.texture = SKTexture(imageNamed: "toggleOn")
        }
    }
    
    func removeMicroPlasticNode() {
        for node in self.children {
            if node.name == "microPlastic" {
                node.removeFromParent()
            }
        }
    }
    
}

extension UIImage {
    static func gradientImage(withBounds: CGRect, startPoint: CGPoint, endPoint: CGPoint , colors: [CGColor]) -> UIImage {
        
        // Configure the gradient layer based on input
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = withBounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = startPoint
        gradientLayer.endPoint = endPoint
        // Render the image using the gradient layer
        UIGraphicsBeginImageContext(gradientLayer.bounds.size)
        gradientLayer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image!
    }
}

