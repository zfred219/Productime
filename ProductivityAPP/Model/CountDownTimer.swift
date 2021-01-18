//
//  CountDownTimer.swift
//  
//
//  Created by Kaixiang Zhang on 4/14/20.
//



//TODO: drow shadow cloud especially in third view
// inclduing sun, mountain
// enlarge then back to emphasize
//Background change color ,,  day bright - > dart night
//TOOD: something show up? with nature like cloud?
//right side view you have sun always animate from some place
//TOOD: login you can have type word and change picture ? by sun rise


/*
var bounds = mainViewControllerInstance.dayCt.bounds
mainViewControllerInstance.dayCt.font = mainViewControllerInstance.dayCt.font.withSize(100)
bounds.size = mainViewControllerInstance.dayCt.intrinsicContentSize
mainViewControllerInstance.dayCt.bounds = bounds
let scaleX = mainViewControllerInstance.dayCt.frame.size.width / bounds.size.width
let scaleY = mainViewControllerInstance.dayCt.frame.size.height / bounds.size.height
mainViewControllerInstance.dayCt.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
UIView.animate(withDuration: 1.0) {
    mainViewControllerInstance.dayCt.transform = .identity
}
    */

import Foundation
import UIKit
import AVFoundation

var mainViewControllerInstance = MainViewController()
var audioPlayer: AVAudioPlayer?
let sun = mainViewControllerInstance.sun!
var morningTotalTime: CGFloat = 0
var afteroonTotalTime: CGFloat = 0
var eveningTotalTime: CGFloat = 0
var finalTotalTime: CGFloat = 5

class DayCounter {
    
    var _day: Int            // count total day
    var _rest = true

    init(day: Int) {
        self._day = day
        playSound()
    }
    
    
    func playSound() {
        do {
            if let fileURL = Bundle.main.path(forResource: "natureSound", ofType: "mp3") {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
            } else {
                print("No file with specified name exists")
            }
        } catch let error {
            print("Can't play the audio file failed with an error \(error.localizedDescription)")
        }
        audioPlayer?.play()
        audioPlayer?.numberOfLoops = -1
        
       
    }
    
    func dayZero() {
        _day += 1
        dayLabel()
        let timer = CountdownTimer(totalT: 0)
        timer.startTimer()
    }
    
    
   
    // sun set -> 25 min
    func newDay() {
        _day += 1
        dayLabel()
        let timer = CountdownTimer(totalT: 15)
        mainViewControllerInstance.timerCt.text = "\(timer.timeFormatted(timer.totalTime))"
        timer.startTimer()
        sunSet()
    }
    
    
    func endDay() {
        _rest = false
        newRest()
    }
    
    // sunRise
    func newRest() {
        let timerCt = mainViewControllerInstance.timerCt!
        if (_day == 0) {
            let timer = CountdownTimer(totalT: 10)
            timerCt.text = "\(timer.timeFormatted(timer.totalTime))"
            timer.startTimer()
            sunRise(time: 10.0)
        } else if (_day % 8 != 0) {
            let timer = CountdownTimer(totalT: 15)
            timerCt.text = "\(timer.timeFormatted(timer.totalTime))"
            timer.startTimer()
            sunRise(time: 15.0)
        } else {
            print("This is a Big rest day!")                //FIXME: longer animation time
            let timer = CountdownTimer(totalT: 25)
            timerCt.text = "\(timer.timeFormatted(timer.totalTime))"
            timer.startTimer()
            sunRise(time: 25.0)
        }
    }
    
    func endRest() {
        _rest = true
        newDay()
    }

    func sunRise(time: Double) {
        
        UIView.animate(withDuration: time-3, delay: 0, options: [.curveEaseOut],
        animations: {
            sun.center.y -= mainViewControllerInstance.view.bounds.height - 400
            sun.alpha = 0.95
            mainViewControllerInstance.view.layoutIfNeeded()
            mainViewControllerInstance.view.backgroundColor = .white
            mainViewControllerInstance.view.alpha = 1
           mainViewControllerInstance.cloud1.fadeIn()
           mainViewControllerInstance.cloud2.fadeIn()
            mainViewControllerInstance.rightMt.fadeIn()
        }, completion: nil)
    }

    
    func sunSet() {
        //let sun = mainViewControllerInstance.sun!
        UIView.animate(withDuration: 15, delay: 0, options: [.curveEaseOut],
               animations: {
                   sun.center.y -= mainViewControllerInstance.view.bounds.height - 1392
                   mainViewControllerInstance.view.layoutIfNeeded()
                   sun.alpha = 0
                mainViewControllerInstance.view.backgroundColor = .black
                mainViewControllerInstance.view.alpha = 0.95
                mainViewControllerInstance.cloud1.fadeOut()
                mainViewControllerInstance.cloud2.fadeOut()
                mainViewControllerInstance.rightMt.fadeOutMt()
                
               }, completion: nil)
    }
    
    func dayLabel() {
        let dayCt = mainViewControllerInstance.dayCt!
        dayCt.alpha = 0
        dayCt.text = "Day \(_day)"
        dayCt.fadeIn(completion: {
        (finished: Bool) -> Void in
        dayCt.fadeOut()
        })
    }
}



class CountdownTimer {
       
       var countdownTimer: Timer!
       var totalTime: Int
       
       init(totalT: Int) {
           self.totalTime = totalT
       }

       func startTimer() {
           countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            
       }
       
       @objc func updateTime() {
           mainViewControllerInstance.timerCt.text = "\(timeFormatted(totalTime - 1))"
           if (totalTime > 0) {
               totalTime -= 1
                finalTotalTime += 1
           } else {
               endTimer()
           }
       
       }

       func endTimer() {
            countdownTimer.invalidate()
        let dayCounter = mainViewControllerInstance.dayCounter
            if (dayCounter._rest == true) {
                dayCounter.endDay()
            } else {
                dayCounter.endRest()
            }

       }

       func timeFormatted(_ totalSeconds: Int) -> String {
           let seconds: Int = totalSeconds % 60
           let minutes: Int = (totalSeconds / 60) % 60
           //     let hours: Int = totalSeconds / 3600
           return String(format: "%02d:%02d", minutes, seconds)
       }
   }

extension UIView {
       func fadeIn(duration: TimeInterval = 1.2, delay: TimeInterval = 0.0, completion: @escaping ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
            self.alpha = 0.85
           }, completion: completion)
       }

       func fadeOut(duration: TimeInterval = 1.2, delay: TimeInterval = 2.5, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
               self.alpha = 0.0
           }, completion: completion)
       }
    
    func fadeOutMt(duration: TimeInterval = 1.2, delay: TimeInterval = 2.5, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
     UIView.animate(withDuration: duration, delay: delay, options: UIView.AnimationOptions.curveEaseIn, animations: {
        self.alpha = 0.15
        }, completion: completion)
    }
   }
