//
//  IndoorNavViewController.swift
//  SmartCane
//
//  Created by Shawn Popal on 4/20/20.
//  Copyright © 2020 Shawn Popal. All rights reserved.
//

import UIKit
import CocoaMQTT
import Speech

class IndoorNavViewController: UIViewController {

    @IBOutlet weak var connectButton: UIButton!
    @IBOutlet weak var disconnectButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    @IBOutlet weak var pingButton: UIButton!
    @IBOutlet weak var liftButton: UIButton!
    
    
    
    let synthesizer = AVSpeechSynthesizer()
    
    
    let mqttClient = CocoaMQTT(clientID: "iOS Device", host: "192.168.86.25", port: 1883)

    override func viewDidLoad() {
        super.viewDidLoad()
        connectButton.layer.cornerRadius = 20
        disconnectButton.layer.cornerRadius = 20
        dropButton.layer.cornerRadius = 20
        pingButton.layer.cornerRadius = 20
        liftButton.layer.cornerRadius = 20
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    
    @IBAction func dropCrumb(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Dropping Breadcrumb")
        synthesizer.speak(utterance)
        
        mqttClient.publish("rpi/gpio", withString: "drop")
    }
    

    @IBAction func connectButton(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Connecting to Cane")
        synthesizer.speak(utterance)
        mqttClient.connect()
    }

    @IBAction func disconnectButton(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Disconnecting from Cane")
        synthesizer.speak(utterance)
        mqttClient.disconnect()
    }
    
    @IBAction func pingLocation(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Pinging Location")
        synthesizer.speak(utterance)
        
        mqttClient.publish("rpi/gpio", withString: "ping")
    }
    
    @IBAction func liftCrumb(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: "Lifting Breadcrumb")
        synthesizer.speak(utterance)
        
        mqttClient.publish("rpi/gpio", withString: "lift")
    }
}
