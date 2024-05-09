//
//  FullScreenImageViewController.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 08.05.24.
//
import UIKit

class FullScreenImageViewController: UIViewController {
    let scrollView = UIScrollView()
    var imageViews: [UIImageView] = []
    var currentPageIndex = 0
    
    init(imageUrls: [String], initialIndex: Int) {
        super.init(nibName: nil, bundle: nil)
        imageUrls.forEach { imageUrl in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.loadImage(from: imageUrl)
            imageViews.append(imageView)
        }
        currentPageIndex = initialIndex
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        view.addSubview(scrollView)
        
        imageViews.forEach { imageView in
            scrollView.addSubview(imageView)
        }
        
        scrollView.isScrollEnabled = false
        
        let swipeLeftGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeLeftGesture.direction = .left
        scrollView.addGestureRecognizer(swipeLeftGesture)
        
        let swipeRightGesture = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe(_:)))
        swipeRightGesture.direction = .right
        scrollView.addGestureRecognizer(swipeRightGesture)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: view.frame.width * CGFloat(imageViews.count), height: view.frame.height)
        scrollView.contentOffset = CGPoint(x: view.frame.width * CGFloat(currentPageIndex), y: 0)
        
        for (index, imageView) in imageViews.enumerated() {
            imageView.frame = CGRect(x: CGFloat(index) * view.frame.width, y: 0, width: view.frame.width, height: scrollView.frame.height)
        }
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        guard let scrollView = sender.view as? UIScrollView else { return }
        
        if sender.direction == .left {
            let nextPageIndex = min(currentPageIndex + 1, imageViews.count - 1)
            scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(nextPageIndex), y: 0), animated: true)
            currentPageIndex = nextPageIndex
        } else if sender.direction == .right {
            let prevPageIndex = max(currentPageIndex - 1, 0)
            scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(prevPageIndex), y: 0), animated: true)
            currentPageIndex = prevPageIndex
        }
    }
}

extension FullScreenImageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        currentPageIndex = pageIndex
    }
}
