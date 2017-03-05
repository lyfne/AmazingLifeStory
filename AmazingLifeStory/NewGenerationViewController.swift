//
//  NewGenerationViewController.swift
//  AmazingLifeStory
//
//  Created by 林逸凡 on 2017/3/5.
//  Copyright © 2017年 Ivan.lin. All rights reserved.
//

import Cocoa

class NewGenerationViewController: NSViewController {
    @IBOutlet weak var fatherLivingObjectView: LivingObjectView!
    @IBOutlet weak var motherLivingObjectView: LivingObjectView!
    @IBOutlet weak var childLivingObjectView: LivingObjectView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        evolute()
    }
    
    func evolute() {
        for _ in 1...20 {
            fatherLivingObjectView.livingObject.evolution()
            motherLivingObjectView.livingObject.evolution()
        }
        
        fatherLivingObjectView.show()
        motherLivingObjectView.show()
    }
    
    @IBAction func generateNewBaby(_ sender: Any) {
        let genes = childLivingObjectView.livingObject.genes
        for index in 0...genes.count-1 {
            if (arc4random_uniform(2) == 0) {
                genes[index].geneValue = fatherLivingObjectView.livingObject.genes[index].geneValue
            }else {
                genes[index].geneValue = motherLivingObjectView.livingObject.genes[index].geneValue
            }
        }
        
        childLivingObjectView.show()
    }
}
