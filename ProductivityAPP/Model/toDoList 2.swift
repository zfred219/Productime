//
//  toDoList.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 4/25/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import Foundation



class ToDoList {
    
    var _todoList: [[String:String]]
    var numberOfevent: Int
    
    init() {
        _todoList = [[String:String]]()
        
        let interviewEvent = [
            "title": "Interview",
            "time": "9:00 AM - 11:00 AM",
            "picture": "1"
        ]
        let hw1 = [
            "title": "61B HW",
            "time": "12:20 PM - 3:00 PM",
            "picture": "2"
        ]
        let dinner = [
            "title": "Dinner",
            "time": "4:00 PM - 6:00 Pm",
            "picture": "3"
        ]
        let partyEvent = [
            "title": "Party?",
            "time": "8:00 PM - 11:00 PM",
            "picture": "4"
        ]
        _todoList.append(interviewEvent)
        _todoList.append(hw1)
        _todoList.append(dinner)
        _todoList.append(partyEvent)
        numberOfevent = 4   //automaticall with 4 events
    }
    
    
    
    func addEvent(event:String, time: String, topic: String) {
        numberOfevent += 1
        var dic = [String : String]()
        dic["title"] = event
        dic["time"] = time
        dic["picture"] = "\(numberOfevent)"
        
        
        //let url = "https://source.unsplash.com/random/?\(topic)"
        
        _todoList.append(dic)
    }
    
    func DeleteEvent(index: Int) {
        _todoList.remove(at: index)
    }
    
    
    
}
