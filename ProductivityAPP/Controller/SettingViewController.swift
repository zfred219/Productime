//
//  SettingViewController.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 4/13/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import UIKit
import AVFoundation



class SettingViewController: UIViewController {

    @IBOutlet weak var sun: UILabel!
    @IBOutlet weak var leftMt: UILabel!
    @IBOutlet weak var rightMt: UILabel!
    @IBOutlet weak var cloud1: UIButton!
    @IBOutlet weak var cloud3: UIButton!
    
    @IBOutlet weak var sound1: UIButton!
    @IBOutlet weak var sound2: UIButton!
    @IBOutlet weak var sound3: UIButton!
    @IBOutlet weak var sound4: UIButton!
    @IBOutlet weak var sound5: UIButton!
    @IBOutlet weak var sound6: UIButton!
    
    
    override func loadView() {
        super.loadView()
        sunAnimation()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createUI()
        
        //sunAnimation()
        
    }
    
    // FIXME : when change to view controller always see
    func sunAnimation() {
       UIView.animate(withDuration: 17, delay: 0, options: [.curveEaseOut],
       animations: {
        self.sun.center.y -= mainViewControllerInstance.view.bounds.height - 400
        self.sun.alpha = 0.95
           mainViewControllerInstance.view.layoutIfNeeded()
       }, completion: nil)
    }
    
    
    
    func createUI() {
        createLeftMount()
        createRightMount()
        createClouds()
        createSun()
        soundCloud()
    }
    
     func createLeftMount() {
            leftMt.clipsToBounds = true
            leftMt.backgroundColor = UIColor(cgColor: UIColor(red: 0.011, green: 0.062, blue: 0.138, alpha: 0.9).cgColor)
            leftMt.layer.cornerRadius = 60
            leftMt.rotate(degrees: 47)
        }
        
    func createRightMount() {
        rightMt.clipsToBounds = true
        rightMt.backgroundColor = UIColor(cgColor: UIColor(red: 0.163, green: 0.343, blue: 0.613, alpha: 0.95).cgColor)
        rightMt.layer.cornerRadius = 60
        rightMt.rotate(degrees: 137)
    }
    
    func createSun() {
           sun.clipsToBounds = true
           sun.layer.cornerRadius = sun.frame.width/2
           sun.layer.masksToBounds = true
           sun.backgroundColor = UIColor(cgColor: UIColor(red: 0.95, green: 0.38, blue: 0.38, alpha: 1).cgColor)
       }
    
    func createClouds() {
        cloud1.clipsToBounds = true
        cloud1.layer.cornerRadius = 20
        cloud1.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        cloud3.clipsToBounds = true
        cloud3.layer.cornerRadius = 20
        cloud3.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
    }
    
    
    // MARK: - SOUND
    
    
    func soundCloud() {
        sound1.clipsToBounds = true
        sound1.layer.cornerRadius = 20
        sound1.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        sound1.alpha = 0
        sound1.isEnabled = false
        
        sound2.clipsToBounds = true
        sound2.layer.cornerRadius = 20
        sound2.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        sound2.alpha = 0
        sound2.isEnabled = false
        
        sound3.clipsToBounds = true
        sound3.layer.cornerRadius = 20
        sound3.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        sound3.alpha = 0
        sound3.isEnabled = false
        sound3.titleLabel!.lineBreakMode = NSLineBreakMode.byWordWrapping
        sound3.titleLabel!.numberOfLines = 2
        
        sound4.clipsToBounds = true
        sound4.layer.cornerRadius = 20
        sound4.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        sound4.alpha = 0
        sound4.isEnabled = false
        
        sound5.clipsToBounds = true
        sound5.layer.cornerRadius = 20
        sound5.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        sound5.alpha = 0
        sound5.isEnabled = false
        
        sound6.clipsToBounds = true
        sound6.layer.cornerRadius = 20
        sound6.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 1).cgColor)
        sound6.alpha = 0
        sound6.isEnabled = false
    }
    
    
    

    
    // float away and float back some clound with sound button
    @IBAction func soundButton(_ sender: Any) {
        cloud1.alpha = 0
        cloud3.alpha = 0
        //sun.alpha = 0
        
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.sound1.fadeIn()
            self.sound1.shake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.sound2.fadeIn()
            self.sound2.shake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.sound3.fadeIn()
            self.sound3.shake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.sound5.fadeIn()
            self.sound5.shake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            self.sound6.fadeIn()
            self.sound6.shake()
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.sound4.fadeIn()
            self.sound4.shake()
        }
        sound1.isEnabled = true
        sound2.isEnabled = true
        sound3.isEnabled = true
        sound4.isEnabled = true
        sound5.isEnabled = true
        sound6.isEnabled = true
    }
    
    
    func changeSound(soundName: String) {
           if (soundName == "None") {
               audioPlayer?.stop()
           } else {
                   do {
                       if let fileURL = Bundle.main.path(forResource: soundName, ofType: "mp3") {
                           audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: fileURL))
                       } else {
                           print("No file with specified name exists")
                       }
                   } catch let error {
                       print("Can't play the audio file failed with an error \(error.localizedDescription)")
                   }
                   audioPlayer?.play()
            audioPlayer?.numberOfLoops = -1
            
           
                    everythingFade()
               }
           }
       

    @IBAction func sound1(_ sender: Any) {
        changeSound(soundName: "forestSound")
    }
    
    @IBAction func sound2(_ sender: Any) {
        changeSound(soundName: "clockSound")
    }
    
    @IBAction func sound3(_ sender: Any) {
        changeSound(soundName: "morningDewSound")
    }
    
    
    @IBAction func sound4(_ sender: Any) {
       changeSound(soundName: "None")
    }
    @IBAction func sound5(_ sender: Any) {
        changeSound(soundName: "rainSound")
    }
    @IBAction func sound6(_ sender: Any) {
        changeSound(soundName: "pianoSound")
    }
    
    func everythingFade() {
        sound1.alpha = 0
        sound1.isEnabled = false
        sound2.alpha = 0
        sound2.isEnabled = false
        sound3.alpha = 0
        sound3.isEnabled = false
        sound4.alpha = 0
        sound4.isEnabled = false
        sound5.alpha = 0
        sound5.isEnabled = false
        sound6.alpha = 0
        sound6.isEnabled = false
        cloud1.fadeIn()
        cloud3.fadeIn()
        sun.fadeIn()
    }
    
    
    
    //MARK: -Statistics
    @IBAction func statButton(_ sender: Any) {
        
    }
}

extension UIView {
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        animation.duration = 1
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
}


