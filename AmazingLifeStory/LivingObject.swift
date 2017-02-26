//
//  LivingObject.swift
//  AmazingLifeStory
//
//  Created by 林逸凡 on 2017/2/18.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import Cocoa
import Darwin

class Node: NSObject {
    init(x: Double, y: Double) {
        position = CGPoint(x:x, y:y)
    }
    
    var position = CGPoint(x: 0.0, y: 0.0)
    var parent: Node?
    var childLeft: Node?
    var childRight: Node?
}

class LivingObject: NSObject {
    //Gene
    var geneOddLength = 0.6
    var geneEvenLength = 0.6
    var geneOddAngle = 0.25
    var geneEvenAngle = 0.25
    var geneNonFirstChildAngleRateLeft = 1.0 //Right is 2.0 - left
    var geneChildrenCount = 5
    
    let geneLengthEvoStep = 0.05
    let geneAngleEvoStep = 0.05
    let geneAngleRateEvoStep = 0.05
    let geneChildrenCountEvoStep = 1
    
    //Other properties
    var nodes = [Node]()
    var lengthOfFirstBranch = 40.0
    
    //phenotype
    var phenotypeOddLength = 0.0
    var phenotypeEvenLength = 40.0
    var phenotypeOddAngle = 0.25
    var phenotypeEvenAngle = 0.25
    
    func getNodeAt(index: Int)->Node? {
        var node: Node?
        
        if (index >= 0 && index < nodes.count) {
            node = nodes[index]
        }
        return node
    }
    
    func reset() {
        phenotypeOddLength = 0.0
        phenotypeEvenLength = lengthOfFirstBranch
        
        nodes.removeAll()
    }
    
    func log() {
        for index in 0...nodes.count-1 {
            print(nodes[index].position)
        }
    }
    
    func growUp(growCount: Int, parentNode: Node) {
        let odd = growCount % 2 == 1
        var ratio = 0.0
        var angle = 0.0
        if(odd) {
            phenotypeOddLength = phenotypeEvenLength * geneOddLength
            ratio = (phenotypeOddLength / phenotypeEvenLength + 1)
            angle = M_PI * phenotypeOddAngle
        }else {
            phenotypeEvenLength = phenotypeOddLength * geneEvenLength
            ratio = (phenotypeEvenLength / phenotypeOddLength + 1)
            angle = M_PI * phenotypeEvenAngle
        }
        
        let x = ratio * Double(parentNode.position.x - parentNode.parent!.position.x) + Double(parentNode.parent!.position.x) - Double(parentNode.position.x)
        let y = ratio * Double(parentNode.position.y - parentNode.parent!.position.y) + Double(parentNode.parent!.position.y) - Double(parentNode.position.y)
        
        let xL = cos(angle * geneNonFirstChildAngleRateLeft) * x - sin(angle * geneNonFirstChildAngleRateLeft) * y + Double(parentNode.position.x)
        let yL = sin(angle * geneNonFirstChildAngleRateLeft) * x + cos(angle * geneNonFirstChildAngleRateLeft) * y + Double(parentNode.position.y)
        
        let xR = cos(-angle * (2.0 - geneNonFirstChildAngleRateLeft)) * x - sin(-angle * (2.0 - geneNonFirstChildAngleRateLeft)) * y + Double(parentNode.position.x)
        let yR = sin(-angle * (2.0 - geneNonFirstChildAngleRateLeft)) * x + cos(-angle * (2.0 - geneNonFirstChildAngleRateLeft)) * y + Double(parentNode.position.y)
        
        let newNodeLeft = Node(x:xL, y:yL)
        let newNodeRight = Node(x:xR, y:yR)
        newNodeLeft.parent = parentNode
        newNodeRight.parent = parentNode
        parentNode.childLeft = newNodeLeft
        parentNode.childRight = newNodeRight
        
        nodes.append(newNodeLeft)
        nodes.append(newNodeRight)
    }
    
    func evolution() {
        
    }
}
