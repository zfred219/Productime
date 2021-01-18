//
//  MainViewController.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 4/13/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import UIKit



class MainViewController: UIViewController {

    @IBOutlet weak var leftMt: UILabel!
    @IBOutlet weak var rightMt: UILabel!
    @IBOutlet weak var sun: UILabel!
    @IBOutlet weak var cloud1: UILabel!
    @IBOutlet weak var cloud2: UILabel!
    @IBOutlet weak var dayCt: UILabel!
    @IBOutlet weak var timerCt: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainViewControllerInstance = self
        createUI()
        checkGesture()
        dayCounter.dayZero()
        print("ss")
    }
    
    
    
    let dayCounter = DayCounter(day: -1)
    var todoListObj = ToDoList()
    
    func checkGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)

        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
       if gesture.direction == .right {
            print("To Left")
        let todoView = self.storyboard?.instantiateViewController(withIdentifier: "todo") as! TodoViewController
        self.present(todoView, animated: true, completion: nil)
       }
       else if gesture.direction == .left {
            print("To Right")
        
        let setView = self.storyboard?.instantiateViewController(withIdentifier: "setting") as! SettingViewController
        self.present(setView, animated: true, completion: nil)
       }
    }

    
    //TODO : right side perform segue
   
    
    
    
    

    func createUI() {
        createLeftMount()
        createRightMount()
        createSun()
        createClouds()
    }
    
    func createSun() {
        sun.clipsToBounds = true
        sun.layer.cornerRadius = sun.frame.width/2
        sun.layer.masksToBounds = true
        sun.backgroundColor = UIColor(cgColor: UIColor(red: 0.95, green: 0.38, blue: 0.38, alpha: 1).cgColor)
    }
    
    func createClouds() {
        
        cloud1.clipsToBounds = true
        cloud1.layer.cornerRadius = 45
        cloud1.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.95).cgColor)
        cloud2.clipsToBounds = true
        cloud2.layer.cornerRadius = 45
        cloud2.backgroundColor = UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.90).cgColor)
        
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

}

extension UIView {
    func rotate(degrees: CGFloat) {
        rotate(radians: CGFloat.pi * degrees / 180.0)
    }

    func rotate(radians: CGFloat) {
        self.transform = CGAffineTransform(rotationAngle: radians)
    }

}




/*
 
    func fetchCalendar()  {
        let string = "https://www.googleapis.com/calendar/v3/calendars/zkx219%40gmail.com/events"
        let url = NSURL(string: string)
        let request = NSMutableURLRequest(url: url! as URL)
        request.setValue("Bearer 309108839580-9a6qrr00qnsktk8vrqpkk6b0urv74fhg.apps.googleusercontent.com", forHTTPHeaderField: "Authorization")
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared

        let mData = session.dataTask(with: request as URLRequest) { (data, response, error) -> Void in
            if let res = response as? HTTPURLResponse {
                print("res: \(res)")
                print("Response: \(String(describing: response))")
            }else{
                print("Error: \(String(describing: error))")
            }
        }
        mData.resume()
    }
    
 
 
 
 
 func writetoGC(token:String, startTime: String, endTime: String, summary: String, description: String) {

     let url = URL(string: "https://www.googleapis.com/calendar/v3/calendars/{YOUR CALENDAR ID HERE}/events")

     let summary1 = confirmationCode + "; " + summary

     let session = URLSession.shared
     print(session)
     var request = NSMutableURLRequest(url: url!)
     request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
     request.httpMethod = "POST"
     print(request)
     // token, startTime, endTime, summary, description

     var myHttpBody: Data = """
                             {
                             "end": {
                             "dateTime": "\(endTime)",
                             "timeZone": "America/Chicago"
                             },
                             "start": {
                             "dateTime": "\(startTime)",
                             "timeZone": "America/Chicago"
                             },
                             "summary": "\(summary1)",
                             "description": "\(description)"
                             }
                         """.data(using: .utf8)! as Data
     do {
         request.httpBody = myHttpBody
     } catch let error {
         print(error.localizedDescription)
     }

     request.addValue("application/json", forHTTPHeaderField: "Content-Type")

     print("Request: ")
     print(request.description)
     print(request.allHTTPHeaderFields)
     print("Body is:")
     print(request.httpBody)

     let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in

         guard error == nil else {
             return
         }

         guard let data = data else {
             return
         }
         sleep(1)
         do {
             //create json object from data
             if let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                 print("Response is:")
                 print(json)
                 print("Description:")
                 print(json.description)
                 print("Debug Description:")
                 print(json.debugDescription)

                 // handle json...
             }
         } catch let error {
             print("Error during Serialization:")
             print(error.localizedDescription)
         }
     })
     task.resume()

     //verifyEntry()
 }
 */
