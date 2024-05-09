//
//  SwipeGestureHandler.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//

import UIKit

protocol SwipeGestureHandlerDelegate: AnyObject {
    func handleSwipe(direction: UISwipeGestureRecognizer.Direction?)
}

class SwipeGestureHandler: NSObject {
    weak var delegate: SwipeGestureHandlerDelegate?
    
    override init() {
        super.init()
    }
    
    func addSwipeGestures(to view: UIView) {
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        view.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = .right
        view.addGestureRecognizer(swipeRightGesture)
    }
    
    @objc private func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        delegate?.handleSwipe(direction: sender.direction)
    }
}
