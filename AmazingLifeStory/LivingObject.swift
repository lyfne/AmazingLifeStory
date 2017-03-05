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

class Gene: NSObject {
    var geneId = 0
    var geneName: String = ""
    var geneValue = 0.0
    var geneEvoStep = 0.0
    var upperBound = 1.0
    var lowerBound = 0.0
    var upOrDownTrend: Int = 5
    
    init(id: Int, name: String, value: Double, evoStep: Double) {
        geneId = id
        geneName = name
        geneValue = value
        geneEvoStep = evoStep
    }
    
    func evolution() {
        var localEvoStep = geneEvoStep
        if (arc4random_uniform(2) == 0) {
            localEvoStep *= 1.7
        }
        if (arc4random_uniform(10) < UInt32(upOrDownTrend)) {
            if (geneValue + localEvoStep < upperBound) {
                geneValue += localEvoStep
            }
        }else {
            if (geneValue - localEvoStep > lowerBound) {
                geneValue -= localEvoStep
            }
        }
    }
}

class LivingObject: NSObject {
    //Gene
    var geneOddLength = Gene(id: 0, name: "GeneOddLength", value: 0.6, evoStep:0.02)
    var geneEvenLength = Gene(id: 1, name: "GeneEvenLength", value: 0.6, evoStep:0.02)
    var geneOddAngle = Gene(id: 2, name: "GeneOddAngle", value: 0.25, evoStep:0.02)
    var geneEvenAngle = Gene(id: 3, name: "GeneEvenAngle", value: 0.25, evoStep:0.02)
    var geneNonFirstChildAngleRateLeft = Gene(id: 4, name: "GeneAngleRateLeft", value: 1.0, evoStep:0.03) //Right is 2.0 - left
    var geneColorR = Gene(id: 5, name: "GeneColorR", value: 0.0, evoStep:0.04)
    var geneColorG = Gene(id: 6, name: "GeneColorG", value: 0.0, evoStep:0.04)
    var geneColorB = Gene(id: 7, name: "GeneColorB", value: 0.0, evoStep:0.04)
    var geneChildrenCount = Gene(id: 8, name: "GeneChildrenCount", value: 5.0, evoStep:1.0)
    var geneLengthOfFirstBranch = Gene(id: 9, name: "GeneLengthOfFirstBranch", value: 40.0, evoStep:4.0)
    var genes = [Gene]()
    
    var nodes = [Node]()
    
    //phenotype
    var phenotypeOddLength = 0.0
    var phenotypeEvenLength = 0.0
    
    override init() {
        phenotypeEvenLength = geneLengthOfFirstBranch.geneValue

        geneOddLength.upperBound = 1.0
        geneEvenLength.upperBound = 1.0
        geneOddAngle.upperBound = 2.0
        geneEvenAngle.upperBound = 2.0
        geneNonFirstChildAngleRateLeft.geneEvoStep = 0.0
        geneChildrenCount.upperBound = 8.0
        geneChildrenCount.lowerBound = 3.0
        geneLengthOfFirstBranch.upperBound = 100.0
        geneLengthOfFirstBranch.lowerBound = 20.0
        
        genes = [geneOddLength, geneEvenLength, geneOddAngle, geneEvenAngle, geneNonFirstChildAngleRateLeft, geneColorR, geneColorG, geneColorB, geneChildrenCount, geneLengthOfFirstBranch]
    }
    
    func getNodeAt(index: Int)->Node? {
        var node: Node?
        
        if (index >= 0 && index < nodes.count) {
            node = nodes[index]
        }
        return node
    }
    
    func reset() {
        phenotypeOddLength = 0.0
        phenotypeEvenLength = geneLengthOfFirstBranch.geneValue
        
        nodes.removeAll()
    }
    
    func growUp(growCount: Int, parentNode: Node) {
        let odd = growCount % 2 == 1
        var ratio = 0.0
        var angle = 0.0
        if(odd) {
            phenotypeOddLength = phenotypeEvenLength * geneOddLength.geneValue
            ratio = (phenotypeOddLength / phenotypeEvenLength + 1)
            angle = M_PI * geneOddAngle.geneValue
        }else {
            phenotypeEvenLength = phenotypeOddLength * geneEvenLength.geneValue
            ratio = (phenotypeEvenLength / phenotypeOddLength + 1)
            angle = M_PI * geneEvenAngle.geneValue
        }
        
        let x = ratio * Double(parentNode.position.x - parentNode.parent!.position.x) + Double(parentNode.parent!.position.x) - Double(parentNode.position.x)
        let y = ratio * Double(parentNode.position.y - parentNode.parent!.position.y) + Double(parentNode.parent!.position.y) - Double(parentNode.position.y)
        
        let xL = cos(angle * geneNonFirstChildAngleRateLeft.geneValue) * x - sin(angle * geneNonFirstChildAngleRateLeft.geneValue) * y + Double(parentNode.position.x)
        let yL = sin(angle * geneNonFirstChildAngleRateLeft.geneValue) * x + cos(angle * geneNonFirstChildAngleRateLeft.geneValue) * y + Double(parentNode.position.y)
        
        let xR = cos(-angle * (2.0 - geneNonFirstChildAngleRateLeft.geneValue)) * x - sin(-angle * (2.0 - geneNonFirstChildAngleRateLeft.geneValue)) * y + Double(parentNode.position.x)
        let yR = sin(-angle * (2.0 - geneNonFirstChildAngleRateLeft.geneValue)) * x + cos(-angle * (2.0 - geneNonFirstChildAngleRateLeft.geneValue)) * y + Double(parentNode.position.y)
        
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
        let index = arc4random_uniform(UInt32(genes.count))
        genes[Int(index)].evolution()
    }
}
