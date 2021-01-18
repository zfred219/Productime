//
//  TodoViewController.swift
//  ProductivityAPP
//
//  Created by Kaixiang Zhang on 4/13/20.
//  Copyright © 2020 Kaixiang Zhang. All rights reserved.
//

import UIKit
import CollectionViewSlantedLayout
public var covers = [[String: String]]()
let todoList = mainViewControllerInstance.todoListObj

class TodoViewController: UIViewController, UIGestureRecognizerDelegate {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewLayout: CollectionViewSlantedLayout!

    //public var covers = [[String: String]]()
    
    let reuseIdentifier = "customViewCell"

    override func loadView() {
        super.loadView()
        covers = todoList._todoList
        
        print(covers)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        todoViewControllerPter = self
        
        
        navigationController?.isNavigationBarHidden = true
        collectionViewLayout.isFirstCellExcluded = true
        collectionViewLayout.isLastCellExcluded = true
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(TodoViewController.handleLongPress))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(lpgr)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
        collectionView.collectionViewLayout.invalidateLayout()
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }

    override var preferredStatusBarUpdateAnimation: UIStatusBarAnimation {
        return UIStatusBarAnimation.slide
    }
    
    @objc func handleLongPress(gestureRecognizer : UILongPressGestureRecognizer){

        if (gestureRecognizer.state != UIGestureRecognizer.State.ended){
            return
        }

        let p = gestureRecognizer.location(in: self.collectionView)

        if let indexPath : NSIndexPath = (self.collectionView?.indexPathForItem(at: p))! as NSIndexPath{
            performSegue(withIdentifier: "popup", sender: indexPath)
        } else {
            print("Nah")
        }
    }
    
    /*
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
         if (indexPath.row == 3 ) { //it's your last cell
            print("ssss")
           //Load more data & reload your collection view
         }
    }
 */

}




extension TodoViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return covers.count
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
                            as? CustomCollectionCell else {
            fatalError()
        }
        
        cell.image = UIImage(named: covers[indexPath.row]["picture"]!)!
        //TODO add text here due to FORLOOP
        cell.event.text = covers[indexPath.row]["title"]
        cell.event.transform = CGAffineTransform(rotationAngle: CGFloat(.pi * 1.94))
        cell.time.text = covers[indexPath.row]["time"]
        cell.time.transform = CGAffineTransform(rotationAngle: CGFloat(.pi * 1.94))
        
    
    
        if let layout = collectionView.collectionViewLayout as? CollectionViewSlantedLayout {
            cell.contentView.transform = CGAffineTransform(rotationAngle: layout.slantingAngle)
        }

        return cell
    }
}

extension TodoViewController: CollectionViewDelegateSlantedLayout {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "deletePop", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destiny = segue.destination as? DeletePopUpViewController, let indexPath1 = sender as? IndexPath {
            destiny.indexPath2 = indexPath1
        }
    }
    

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: CollectionViewSlantedLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGFloat {
        return collectionViewLayout.scrollDirection == .vertical ? 275 : 325
    }
}

extension TodoViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard let collectionView = collectionView else {return}
        guard let visibleCells = collectionView.visibleCells as? [CustomCollectionCell] else {return}
        for parallaxCell in visibleCells {
            let yOffset = (collectionView.contentOffset.y - parallaxCell.frame.origin.y) / parallaxCell.imageHeight * 0.7
            let xOffset = (collectionView.contentOffset.x - parallaxCell.frame.origin.x) / parallaxCell.imageWidth
            parallaxCell.offset(CGPoint(x: xOffset * xOffsetSpeed, y: yOffset * yOffsetSpeed))
        }
    }
}
