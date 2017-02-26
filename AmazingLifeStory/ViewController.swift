//
//  ViewController.swift
//  AmazingLifeStory
//
//  Created by 林逸凡 on 2017/2/18.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var livingObjectWindow: LivingObjectView!
    @IBOutlet weak var geneOddLengthTextField: NSTextField!
    @IBOutlet weak var geneEvenLengthTextField: NSTextField!
    @IBOutlet weak var geneOddAngleTextField: NSTextField!
    @IBOutlet weak var geneEvenAngleTextField: NSTextField!
    @IBOutlet weak var geneAngleRateLeftTextField: NSTextField!
    @IBOutlet weak var geneChildrenCountTextField: NSTextField!
    @IBOutlet weak var lengthOfFirstBirthTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obj = livingObjectWindow.getLivingObject()
        geneOddLengthTextField.stringValue = String(obj.geneOddLength)
        geneEvenLengthTextField.stringValue = String(obj.geneEvenLength)
        geneOddAngleTextField.stringValue = String(obj.geneOddAngle)
        geneEvenAngleTextField.stringValue = String(obj.geneEvenAngle)
        geneAngleRateLeftTextField.stringValue = String(obj.geneNonFirstChildAngleRateLeft)
        geneChildrenCountTextField.stringValue = String(obj.geneChildrenCount)
        lengthOfFirstBirthTextField.stringValue = String(obj.lengthOfFirstBranch)
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func generateLife(_ sender: Any) {
        let obj = livingObjectWindow.getLivingObject()
        if(geneOddLengthTextField.doubleValue > 0.0) {
            obj.geneOddLength = geneOddLengthTextField.doubleValue
        }
        if(geneEvenLengthTextField.doubleValue > 0.0) {
            obj.geneEvenLength = geneEvenLengthTextField.doubleValue
        }
        obj.phenotypeOddAngle = geneOddAngleTextField.doubleValue
        obj.phenotypeEvenAngle = geneEvenAngleTextField.doubleValue
        if(geneAngleRateLeftTextField.doubleValue > 0 && geneAngleRateLeftTextField.doubleValue < 2.0) {
            obj.geneNonFirstChildAngleRateLeft = geneAngleRateLeftTextField.doubleValue
        }
        if(geneChildrenCountTextField.integerValue > 0 && geneChildrenCountTextField.integerValue <= 10) {
            obj.geneChildrenCount = geneChildrenCountTextField.integerValue
        }
        if (lengthOfFirstBirthTextField.doubleValue >= 0.0 && lengthOfFirstBirthTextField.doubleValue <= 100.0) {
            obj.lengthOfFirstBranch = lengthOfFirstBirthTextField.doubleValue
        }
        
        livingObjectWindow.show()
    }
}

