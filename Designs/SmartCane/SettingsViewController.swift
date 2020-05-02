//
//  SettingsViewController.swift
//  SmartCane
//
//  Created by Shawn Popal on 4/21/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//

import UIKit
import CocoaMQTT
import Speech

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var hapticButton: UIButton!
    
    let synthesizer = AVSpeechSynthesizer()
    
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "192.168.86.25", port: 1883)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connectButton.layer.cornerRadius = 20
        disconnectButton.layer.cornerRadius = 20
        hapticButton.layer.cornerRadius = 20
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func connectToServer(_ sender: Any) {
        
        let utterance = AVSpeechUtterance(string: "Connecting to Cane")
        synthesizer.speak(utterance)
        mqttClient.connect()
    }
    
    @IBAction func disconnectFromServer(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Disconnect from Cane")
        synthesizer.speak(utterance)
        mqttClient.disconnect()
    }
    
    @IBAction func toggleHaptic(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Toggling Haptic Feedback")
        synthesizer.speak(utterance)
        
        mqttClient.publish("rpi/gpio", withString: "haptic")
    }
    
}
