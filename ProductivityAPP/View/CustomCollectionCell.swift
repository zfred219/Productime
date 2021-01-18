//
//  CustomCollectionCell.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 4/13/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import Foundation
import UIKit
import CollectionViewSlantedLayout


let yOffsetSpeed: CGFloat = 150.0
let xOffsetSpeed: CGFloat = 100.0

class CustomCollectionCell: CollectionViewSlantedCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var event: UILabel!
    @IBOutlet weak var time: UILabel!
    
    
    private var gradient = CAGradientLayer()

    override func awakeFromNib() {
        super.awakeFromNib()

        if let backgroundView = backgroundView {
            gradient.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
            gradient.locations = [0.2, 1.0]
            gradient.frame = backgroundView.bounds
            backgroundView.layer.addSublayer(gradient)
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        if let backgroundView = backgroundView {
            gradient.frame = backgroundView.bounds
        }
    }
    
    var eventText: String = String() {
        didSet {
            event.text = eventText
        }
    }
    
    var timeText: String = String() {
        didSet {
            time.text = timeText
        }
    }
 

    var image: UIImage = UIImage() {
        didSet {
            imageView.image = image
        }
    }

    var imageHeight: CGFloat {
        return (imageView?.image?.size.height) ?? 0.0
    }

    var imageWidth: CGFloat {
        return (imageView?.image?.size.width) ?? 0.0
    }

    func offset(_ offset: CGPoint) {
        imageView.frame = imageView.bounds.offsetBy(dx: offset.x, dy: offset.y)
    }
}
