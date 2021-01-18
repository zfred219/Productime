//
//  ChildHostingController.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 5/1/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import UIKit
import SwiftUI


struct SecondView: View {
    
    @State var pickerSelectedItem = 0
    @State var dataPoints: [[CGFloat]] = [
        [finalTotalTime/2, 20, 50],
        [150, 80, 70],
        [20, 50, 10],
        [20, 20, 50],
        [5, 60, 120],
        [150, 20, 50],
        [12, 30, 5],
        
    ]
    
    
    var body: some View {
        ZStack {
            Color(UIColor(cgColor: UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.95).cgColor)).edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Focus Time")
                    .font(.system(size: 45))
                    .fontWeight(.heavy)
                    .padding(.bottom, 50)
                    .foregroundColor(Color(UIColor.white))
                
                
                HStack (spacing: 25) {
                        BarView(value: dataPoints[pickerSelectedItem][0], time: "Morning")
                        BarView(value: dataPoints[pickerSelectedItem][1], time: "Afternoon")
                        BarView(value: dataPoints[pickerSelectedItem][2], time: "Evening")
                    }.padding(.top, 80)
                        .animation(.default)
                
            
                Picker(selection: $pickerSelectedItem, label: Text("")) {
                    Text("Mon").tag(0)
                    Text("Tue").tag(1)
                    Text("Wed").tag(2)
                    Text("Thu").tag(3)
                    Text("Fri").tag(4)
                    Text("Sat").tag(5)
                    Text("Sun").tag(6)
                    
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal, 15)
                    .padding(.top, 120)
            }
        }
    }
}

struct BarView: View {
    var value: CGFloat = 0
    var time: String
    
    var body: some View {
        VStack {
            ZStack (alignment: .bottom) {
                Capsule().frame(width: 25, height: 200)
                    .foregroundColor(Color(UIColor(cgColor: UIColor(red: 0.011, green: 0.062, blue: 0.138, alpha: 0.9).cgColor)))
                Capsule().frame(width: 25, height: value)
                .foregroundColor(Color(UIColor(cgColor: UIColor(red: 0.95, green: 0.38, blue: 0.38, alpha: 1).cgColor)))
            }
            
           Text(time).padding(.top, 10)
                .font(.system(size: 20))
            
        }
    }
}



class ChildHostingController: UIHostingController<SecondView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: SecondView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
