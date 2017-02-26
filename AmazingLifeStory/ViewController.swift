//
//  ViewController.swift
//  AmazingLifeStory
//
//  Created by 林逸凡 on 2017/2/18.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var RunningTimesTextField: NSTextField!
    @IBOutlet weak var livingObjectWindow: LivingObjectView!
    @IBOutlet weak var geneOddLengthTextField: NSTextField!
    @IBOutlet weak var geneEvenLengthTextField: NSTextField!
    @IBOutlet weak var geneOddAngleTextField: NSTextField!
    @IBOutlet weak var geneEvenAngleTextField: NSTextField!
    @IBOutlet weak var geneAngleRateLeftTextField: NSTextField!
    @IBOutlet weak var geneColorR: NSTextField!
    @IBOutlet weak var geneColorG: NSTextField!
    @IBOutlet weak var geneColorB: NSTextField!
    @IBOutlet weak var geneChildrenCountTextField: NSTextField!
    @IBOutlet weak var lengthOfFirstBirthTextField: NSTextField!
    
    var runningTimes = 0
    var evoluting = false
    var timer: Timer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func updateUI() {
        RunningTimesTextField.stringValue = "Times: " + String(runningTimes)
        
        let obj = livingObjectWindow.getLivingObject()
        geneOddLengthTextField.stringValue = String(obj.geneOddLength.geneValue)
        geneEvenLengthTextField.stringValue = String(obj.geneEvenLength.geneValue)
        geneOddAngleTextField.stringValue = String(obj.geneOddAngle.geneValue)
        geneEvenAngleTextField.stringValue = String(obj.geneEvenAngle.geneValue)
        geneAngleRateLeftTextField.stringValue = String(obj.geneNonFirstChildAngleRateLeft.geneValue)
        geneColorR.stringValue = String(obj.geneColorR.geneValue)
        geneColorG.stringValue = String(obj.geneColorG.geneValue)
        geneColorB.stringValue = String(obj.geneColorB.geneValue)
        geneChildrenCountTextField.stringValue = String(obj.geneChildrenCount.geneValue)
        lengthOfFirstBirthTextField.stringValue = String(obj.geneLengthOfFirstBranch.geneValue)
    }
    
    @IBAction func generateLife(_ sender: Any) {
        let obj = livingObjectWindow.getLivingObject()
        if(geneOddLengthTextField.doubleValue > 0.0) {
            obj.geneOddLength.geneValue = geneOddLengthTextField.doubleValue
        }
        if(geneEvenLengthTextField.doubleValue > 0.0) {
            obj.geneEvenLength.geneValue = geneEvenLengthTextField.doubleValue
        }
        if(geneOddAngleTextField.doubleValue > 0.0 && geneOddAngleTextField.doubleValue < 2.0) {
            obj.geneOddAngle.geneValue = geneOddAngleTextField.doubleValue
        }
        if(geneEvenAngleTextField.doubleValue > 0.0 && geneEvenAngleTextField.doubleValue < 2.0) {
            obj.geneEvenAngle.geneValue = geneEvenAngleTextField.doubleValue
        }
        if(geneAngleRateLeftTextField.doubleValue > 0 && geneAngleRateLeftTextField.doubleValue < 2.0) {
            obj.geneNonFirstChildAngleRateLeft.geneValue = geneAngleRateLeftTextField.doubleValue
        }
        if(geneColorR.doubleValue > 0 && geneColorR.doubleValue < 1.0) {
            obj.geneColorR.geneValue = geneColorR.doubleValue
        }
        if(geneColorG.doubleValue > 0 && geneColorG.doubleValue < 1.0) {
            obj.geneColorG.geneValue = geneColorG.doubleValue
        }
        if(geneColorB.doubleValue > 0 && geneColorB.doubleValue < 1.0) {
            obj.geneColorB.geneValue = geneColorB.doubleValue
        }
        if(geneChildrenCountTextField.integerValue > 0 && geneChildrenCountTextField.integerValue <= 10) {
            obj.geneChildrenCount.geneValue = geneChildrenCountTextField.doubleValue
        }
        if (lengthOfFirstBirthTextField.doubleValue >= 0.0 && lengthOfFirstBirthTextField.doubleValue <= 100.0) {
            obj.geneLengthOfFirstBranch.geneValue = lengthOfFirstBirthTextField.doubleValue
        }
        
        livingObjectWindow.show()
    }
    
    @IBAction func evolute(_ sender: Any) {
        if (evoluting) {
            if (timer != nil) {
                timer!.invalidate()
            }
        }else {
            timer = Timer.scheduledTimer(timeInterval: 0.1, target:self,selector:#selector(ViewController.tickDown), userInfo:nil,repeats:true)
        }
        
        evoluting = !evoluting
    }
    
    func tickDown() {
        runningTimes += 1
        self.livingObjectWindow.livingObject.evolution()
        self.livingObjectWindow.show()
        
        updateUI()
    }
}

