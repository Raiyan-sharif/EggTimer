//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    
    let eggTimes = ["Soft": 300, "Medium": 420, "Hard":720]

    @IBOutlet weak var titlleLabel: UILabel!
    
    var secondsRemaining = 60
    
    @IBOutlet weak var progressBar: UIProgressView!
    var timer = Timer()
    var valHardness:Float = 0.0
    @IBAction func hardnessSelected(_ sender: UIButton) {
//        print(sender.currentTitle!)
        progressBar.progress = 0.0
        timer.invalidate()
        let hardness = sender.currentTitle!
        titlleLabel.text = "\(hardness) is Boiling"
        secondsRemaining = eggTimes[hardness]!
        valHardness = Float(secondsRemaining)
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer(){
        if secondsRemaining > 0{
//            print("\(secondsRemaining) seconds")
            if valHardness - Float(secondsRemaining) == 0{
                progressBar.progress = 0.0
            }
            else{
            progressBar.progress = (valHardness - Float(secondsRemaining)) / valHardness
            }
            
            secondsRemaining -= 1
        }
        
        else{
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.progressBar.progress = 0.0
                self.titlleLabel.text = "How do you like your eggs?"
            }
            timer.invalidate()
            progressBar.progress = 1.0
            titlleLabel.text = "Done"
            let systemSoundID: SystemSoundID = 1016

            // to play sound
            AudioServicesPlaySystemSound (systemSoundID)
            
            
            
        }
    }
    

}
