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
    
    var runningTimes = 0
    var evoluting = false
    var timer: Timer?
    var geneVCs = [CustomGeneViewController]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initGeneControlView()
        updateUI()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    func initGeneControlView() {
        let genes = livingObjectWindow.livingObject.genes
        for index in 0...genes.count-1 {
            let controller = self.storyboard?.instantiateController(withIdentifier: "CustomGeneViewController") as! CustomGeneViewController
            self.addChildViewController(controller)
            self.view.addSubview(controller.view)
            controller.fillData(gene: genes[index])
            controller.view.frame.origin.x = 526
            controller.view.frame.origin.y = CGFloat(474 - index * 27);
            
            geneVCs.append(controller)
        }
    }
    
    func updateUI() {
        RunningTimesTextField.stringValue = "Times: " + String(runningTimes)
        for index in 0...geneVCs.count-1 {
            geneVCs[index].updateData()
        }
    }
    
    func applyDada() {
        for index in 0...geneVCs.count-1 {
            geneVCs[index].applyData()
        }
    }
    
    @IBAction func generateLife(_ sender: Any) {
        applyDada()
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

