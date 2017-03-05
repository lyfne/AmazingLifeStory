//
//  CustomGeneViewController.swift
//  AmazingLifeStory
//
//  Created by 林逸凡 on 2017/2/28.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import Cocoa

class CustomGeneViewController: NSViewController {

    @IBOutlet weak var GeneNameTextField: NSTextField!
    @IBOutlet weak var InputValueTextField: NSTextField!
    @IBOutlet weak var balanceLevelIndicator: NSLevelIndicator!
    
    var connectedGene: Gene?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do view setup here.
    }
    
    func fillData(gene: Gene) {
        connectedGene = gene
        
        self.GeneNameTextField.stringValue = gene.geneName
        self.InputValueTextField.stringValue = String(gene.geneValue)
    }
    
    func applyData() {
        if (connectedGene != nil) {
            if (InputValueTextField.doubleValue > connectedGene!.lowerBound && InputValueTextField.doubleValue < connectedGene!.upperBound) {
                connectedGene?.geneValue = InputValueTextField.doubleValue
            }
        }
    }
    
    func updateData() {
        if (connectedGene != nil) {
            InputValueTextField.stringValue = String(connectedGene!.geneValue)
        }
    }

    @IBAction func evoLevelUpdate(_ sender: Any) {
        if (connectedGene != nil) {
            connectedGene!.upOrDownTrend = balanceLevelIndicator.integerValue
            print(connectedGene!.upOrDownTrend)
        }
    }
}
