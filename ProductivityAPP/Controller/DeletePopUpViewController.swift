//
//  DeletePopUpViewController.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 5/1/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import UIKit
import Foundation

var todoViewControllerPter = TodoViewController()

class DeletePopUpViewController: UIViewController {

    @IBOutlet weak var todoText: UITextField!

    @IBOutlet weak var fromTimeTF: HSUnderLineTextField!
    @IBOutlet weak var toTimeTF: HSUnderLineTextField!
    @IBOutlet weak var popUpWindow: UILabel!
    @IBOutlet weak var backButton: UIButton!
    var indexPath2: IndexPath!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showText()
        setting()
    }
    
    func setting() {
        todoText.isUserInteractionEnabled = false
        fromTimeTF.isUserInteractionEnabled = false
        toTimeTF.isUserInteractionEnabled = false
        popUpWindow.layer.masksToBounds = true
        popUpWindow.layer.cornerRadius = 33
        popUpWindow.backgroundColor = UIColor(cgColor: UIColor(red: 0.011, green: 0.062, blue: 0.138, alpha: 0.9).cgColor)
        
        backButton.tintColor = UIColor(cgColor: UIColor(red: 0.8235, green: 0.3882, blue: 0.3098, alpha: 1).cgColor)
    }
    
    
    func showText() {
        let time = matches(for: "[0-9][0-9]?:[0-9][0-9]? [A-Z]M", in: covers[indexPath2.row]["time"]!)
        todoText.text = covers[indexPath2.row]["title"]
        fromTimeTF.text = time[0]
        toTimeTF.text = time[1]
    }
    
    
    
    @IBAction func deleteButton(_ sender: Any) {
        todoList.DeleteEvent(index: indexPath2.row)
        dismiss(animated: true, completion: nil)
        todoViewControllerPter.loadView()
        todoViewControllerPter.viewDidLoad()
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    //Get time
    func matches(for regex: String, in text: String) -> [String] {
        do {
            let regex = try NSRegularExpression(pattern: regex)
            let results = regex.matches(in: text,
                                        range: NSRange(text.startIndex..., in: text))
            return results.map {
                String(text[Range($0.range, in: text)!])
            }
        } catch let error {
            print("invalid regex: \(error.localizedDescription)")
            return []
        }
    }
    
}

