//
//  LivingObjectView.swift
//  AmazingLifeStory
//
//  Created by 林逸凡 on 2017/2/25.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import Cocoa

class LivingObjectView: NSView {
    
    var livingObject = LivingObject();
    var bShow = false
    
    override func draw(_ dirtyRect: NSRect) {
        super.draw(dirtyRect)
        if (bShow) {
            let lineWidth: CGFloat = 1.0
            let finalPath = NSBezierPath()
            finalPath.lineWidth = lineWidth
            
            finalPath.move(to: livingObject.getNodeAt(index: 0)!.position)
            finalPath.line(to: livingObject.getNodeAt(index: 1)!.position)
            
            for drawCount in 2...livingObject.nodes.count-1 {
                if (drawCount % 2 == 0 && livingObject.getNodeAt(index: drawCount)!.parent != nil) {
                    let parentNode = livingObject.getNodeAt(index: drawCount)!.parent!
                    
                    if (parentNode.childLeft != nil && parentNode.childRight != nil)
                    {
                        let pathL = NSBezierPath()
                        pathL.move(to: parentNode.position)
                        pathL.curve(to: parentNode.childLeft!.position, controlPoint1: NSPoint(x:parentNode.childLeft!.position.x, y:parentNode.position.y), controlPoint2: NSPoint(x:parentNode.childLeft!.position.x, y:parentNode.position.y))
                        let pathR = NSBezierPath()
                        pathR.move(to: parentNode.position)
                        //pathR.line(to: parentNode.childRight!.position)
                        pathR.curve(to: parentNode.childRight!.position, controlPoint1: NSPoint(x:parentNode.childRight!.position.x, y:parentNode.position.y), controlPoint2: NSPoint(x:parentNode.childRight!.position.x, y:parentNode.position.y))
                        finalPath.append(pathL)
                        finalPath.append(pathR)
                    }
                }
            }
            
            let color = NSColor(red: CGFloat(livingObject.geneColorR.geneValue), green: CGFloat(livingObject.geneColorG.geneValue), blue: CGFloat(livingObject.geneColorB.geneValue), alpha: 1.0)
            color.setStroke()
            finalPath.stroke()
        }
    }
    
    func show() {
        livingObject.reset()
        let rootNode = Node(x: Double(bounds.width) / 2.0, y: Double(bounds.height) * 0.3)
        let subRootNode = Node(x:Double(bounds.width) / 2.0, y:Double(bounds.height) * 0.3 + livingObject.geneLengthOfFirstBranch.geneValue)
        subRootNode.parent = rootNode
        livingObject.nodes.append(rootNode)
        livingObject.nodes.append(subRootNode)
        
        for growCount in 1...Int(livingObject.geneChildrenCount.geneValue) {
            let nodeMax = Int(pow(2.0, Double(growCount - 1)))
            for nodeCount in 1...nodeMax {
                if (self.livingObject.getNodeAt(index: nodeCount) != nil) {
                    livingObject.growUp(growCount: growCount, parentNode: livingObject.getNodeAt(index: nodeCount+nodeMax-1)!)
                }
            }
        }
        
        bShow = true
        setNeedsDisplay(bounds)
    }
    
    func getLivingObject()->LivingObject {
        return livingObject
    }
}
