//
//  ScollPopUpViewController.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 4/30/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import UIKit
import Foundation

class ScollPopUpViewController: UIViewController {

    @IBOutlet var popUpView: UIView!
    @IBOutlet weak var popUpWindow: UILabel!
    @IBOutlet weak var toDoLabel: UILabel!
    @IBOutlet weak var todoTextField: HSUnderLineTextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var fromTimeTF: HSUnderLineTextField!
    @IBOutlet weak var toTimeTF: HSUnderLineTextField!
    @IBOutlet weak var topicTF: HSUnderLineTextField!
    
    
    var startTimePicker =  UIDatePicker()
    var endTimePicker = UIDatePicker()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        popUpWindowSetting()
        todoFieldSetting()
        
        fromTimeTF.addTarget(self, action: #selector(fromTargeFunction), for: .touchDown)
        toTimeTF.addTarget(self, action: #selector(toTargeFunction), for: .touchDown)
    }
    
    
    @IBAction func cancelAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        mainViewControllerInstance.todoListObj.addEvent(event: todoTextField.text!, time: "\(fromTimeTF.text!) - \(toTimeTF.text!)", topic: topicTF.text!)
        todoViewControllerPter.loadView()
        todoViewControllerPter.viewDidLoad()
       dismiss(animated: true, completion: nil)
    }
    
        
  
    func popUpWindowSetting() {
        popUpWindow.layer.masksToBounds = true
        popUpWindow.layer.cornerRadius = 33
        popUpWindow.backgroundColor = UIColor(cgColor: UIColor(red: 0.01, green: 0.06, blue: 0.14, alpha: 1.00)
                .cgColor)
        
        saveButton.clipsToBounds = true
        saveButton.layer.cornerRadius = saveButton.frame.width/2
        saveButton.layer.masksToBounds = true
        saveButton.backgroundColor = UIColor(cgColor: UIColor(red: 0.8235, green: 0.3882, blue: 0.3098, alpha: 1).cgColor)
        backButton.tintColor = UIColor(cgColor: UIColor(red: 0.8235, green: 0.3882, blue: 0.3098, alpha: 1).cgColor)
        
    }
    
    func todoFieldSetting() {
        //toDoLabel.textColor = UIColor(cgColor: UIColor(red: 0.5098, green: 0.3961, blue: 0.3961, alpha: 1).cgColor)
        todoTextField.attributedPlaceholder = NSAttributedString(string: "Add an event..",
        attributes: [NSAttributedString.Key.foregroundColor: UIColor(cgColor: UIColor(red: 0.5098, green: 0.3961, blue: 0.3961, alpha: 1).cgColor)])
    }
    
    
    
    
    
    
    //Start datePicker
    @objc func fromTargeFunction(textField: UITextField) {
        openStartTimePicker()
    }
    @objc func toTargeFunction(textField: UITextField) {
        openEndTimePicker()
    }

    @objc func openStartTimePicker()  {
        startTimePicker.datePickerMode = UIDatePicker.Mode.time
        startTimePicker.frame = CGRect(x: 0.0, y: (self.view.frame.height/2 + 100), width: self.view.frame.width * 0.9, height: 200.0)
        startTimePicker.center.x = self.view.center.x
        startTimePicker.layer.masksToBounds = true
        startTimePicker.layer.cornerRadius = 25
        startTimePicker.backgroundColor = UIColor(cgColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor)
        self.view.addSubview(startTimePicker)
        startTimePicker.addTarget(self, action: #selector(ScollPopUpViewController.startTimeDiveChanged), for: UIControl.Event.valueChanged)
        
    }

    @objc func startTimeDiveChanged(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        fromTimeTF.text = formatter.string(from: sender.date)
        startTimePicker.removeFromSuperview() // if you want to remove time picker
    }
    
    @objc func openEndTimePicker()  {
          endTimePicker.datePickerMode = UIDatePicker.Mode.time
          endTimePicker.frame = CGRect(x: 0.0, y: (self.view.frame.height/2 + 100), width: self.view.frame.width * 0.9, height: 200.0)
          endTimePicker.center.x = self.view.center.x
          endTimePicker.layer.masksToBounds = true
          endTimePicker.layer.cornerRadius = 25
          endTimePicker.backgroundColor = UIColor(cgColor: UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor)
          self.view.addSubview(endTimePicker)
          endTimePicker.addTarget(self, action: #selector(ScollPopUpViewController.endTimeDiveChanged), for: UIControl.Event.valueChanged)
          
      }

      @objc func endTimeDiveChanged(sender: UIDatePicker) {
          let formatter = DateFormatter()
        formatter.timeStyle = .short
          toTimeTF.text = formatter.string(from: sender.date)
          endTimePicker.removeFromSuperview() // if you want to remove time picker
      }
    
    
    

    //start image from unsplash
    /*
    func getImage() {
        var image: UIImage?
        let urlString = "https://source.unsplash.com/1000x1000/\(topicTF.text!)"
        let url = NSURL(string: urlString)! as URL
        if let imageData: NSData = NSData(contentsOf: url) {
            image = UIImage(data: imageData as Data)
            
            
            
          let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
           if let filePath = paths.first?.appendingPathComponent("MyImageName.png") {
               // Save image.
               do {
                try image!.pngData()?.write(to: filePath, options: .atomic)
               }
               catch {
                  // Handle the error
               }
           }

            
            
            
            
        
        }
 
  */
    
    
    
}


