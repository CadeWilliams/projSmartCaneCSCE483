//
//  ViewController.swift
//  SmartCane
//
//  Created by Shawn Popal on 3/10/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//

import UIKit
import Speech

class ViewController: UIViewController {

    
    
    @IBOutlet weak var navButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()
    
    
    
    @IBAction func speakNavigation(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Navigation")
        synthesizer.speak(utterance)
    }
    
    @IBAction func speakSettings(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Settings")
        synthesizer.speak(utterance)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navButton.layer.cornerRadius = 20
        settingsButton.layer.cornerRadius = 20
        
        let utterance = AVSpeechUtterance(string: "Main Page")
        synthesizer.speak(utterance)
        
    }


}



