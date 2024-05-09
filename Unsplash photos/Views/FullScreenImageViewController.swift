//
//  FullScreenImageViewController.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 08.05.24.
//

import UIKit

class FullScreenImageViewController: UIViewController {
    let viewModel: FullScreenImageViewModel
    var scrollView = UIScrollView()
    var imageViews: [UIImageView] = []
    
    init(viewModel: FullScreenImageViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        
        viewModel.imageUrls.forEach { imageUrl in
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            imageView.loadImage(from: imageUrl)
            imageViews.append(imageView)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        view.backgroundColor = .black
        
        scrollView = UIScrollView(frame: view.bounds)
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
        
        for (index, imageView) in imageViews.enumerated() {
            imageView.frame = CGRect(x: CGFloat(index) * view.frame.width, y: 0, width: view.frame.width, height: scrollView.frame.height)
        }
        
        let initialOffsetX = CGFloat(viewModel.currentPageIndex) * view.frame.width
        scrollView.contentOffset = CGPoint(x: initialOffsetX, y: 0)
    }
    
    @objc func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        guard let scrollView = sender.view as? UIScrollView else { return }
        
        var nextPageIndex = viewModel.currentPageIndex
        if sender.direction == .left {
            nextPageIndex = min(viewModel.currentPageIndex + 1, imageViews.count - 1)
        } else if sender.direction == .right {
            nextPageIndex = max(viewModel.currentPageIndex - 1, 0)
        }
        
        scrollView.setContentOffset(CGPoint(x: view.frame.width * CGFloat(nextPageIndex), y: 0), animated: true)
        viewModel.currentPageIndex = nextPageIndex
    }
}

extension FullScreenImageViewController: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageIndex = Int(scrollView.contentOffset.x / scrollView.frame.width)
        viewModel.currentPageIndex = pageIndex
    }
}
