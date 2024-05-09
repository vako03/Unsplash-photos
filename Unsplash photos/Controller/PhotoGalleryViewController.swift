//
//  ViewController.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 08.05.24.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    let viewModel = ImageViewModel()
    var collectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up navigation bar title
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.blue]
        title = "გალერეა"
        
        // Set title font size and style
        if let titleLabel = self.navigationItem.titleView as? UILabel {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 32)
        }
        
        setupCollectionView()
        viewModel.fetchImages {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical // Ensure vertical scrolling
        let spacing: CGFloat = 2.0
        let itemWidth = (UIScreen.main.bounds.width - (spacing * 4)) / 3 // Calculate width for 3 items with spacing
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageUrls.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.imageUrl = viewModel.imageUrls[indexPath.item]
        return cell
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenViewController = FullScreenImageViewController(imageUrls: viewModel.imageUrls, initialIndex: indexPath.item)
        navigationController?.pushViewController(fullScreenViewController, animated: true)
    }
}
