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
    
    var countdownTimer: Timer!
    
    var remainTime = 0
    var neededTime = 0
    var eggType = ""
    
    var player: AVAudioPlayer! //player必须作为属性，如果放到局部变量，不等发出声音在调用后立即销毁，听不到声音
    /*
    ref：https://stackoverflow.com/questions/29379524/avaudioplayer-play-does-not-play-sound
    The problem is that Player, your AVAudioPlayer, is a local variable. So it goes out of existence immediately - before it can even start playing, let alone finish playing.
    Solution: make it a property instead, so that it will persist.
    */
    
    @IBOutlet weak var statusLable: UILabel!
    
    @IBOutlet weak var progressBar: UIProgressView!
    
    let eggTime:[String: Int] = [
        "Soft":5*1,
        "Medium":7*1,
        "Hard":12*1
        
    ]
    


    @objc func updateTime() {
        
        
        progressBar.progress = ( Float(neededTime) - Float(remainTime) ) / Float(neededTime)
        var unit = "seconds"
        if remainTime <= 1 {
            unit = "second"
        }
        statusLable.text = "\(remainTime) \(unit) left for \(eggType)"
        if remainTime != 0 {
            remainTime -= 1
        } else {
            playSound()
            statusLable.text = "Done!"
            countdownTimer.invalidate()
        }
        
        
    }

    

    @IBAction func hardnessSelected(_ sender: UIButton) {
        
        if countdownTimer != nil {
            countdownTimer.invalidate()
        }
        
        let hardness = sender.currentTitle!
        eggType = hardness
        remainTime = eggTime[hardness]!
        neededTime = remainTime
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    func playSound() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
                
    }
    
    
}
