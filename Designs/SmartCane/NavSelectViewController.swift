//
//  NavSelectViewController.swift
//  SmartCane
//
//  Created by Shawn Popal on 3/19/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//


import UIKit
import Speech

class NavSelectViewController: UIViewController {

    
    
    @IBOutlet weak var outdoorButton: UIButton!
    @IBOutlet weak var indoorButton: UIButton!
    let synthesizer = AVSpeechSynthesizer()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        outdoorButton.layer.cornerRadius = 20
        indoorButton.layer.cornerRadius = 20
        
    }

    
    @IBAction func speakIndoor(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Indoor")
        synthesizer.speak(utterance)
    }
    

}
