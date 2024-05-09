//
//  PhotoGalleryViewController.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 08.05.24.
//

import UIKit

class PhotoGalleryViewController: UIViewController {
    let viewModel = PhotoGalleryViewModel()
    var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, ImageItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "გალერეა"
        setupCollectionView()
        viewModel.fetchImages {
            DispatchQueue.main.async {
                self.applySnapshot()
            }
        }
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let spacing: CGFloat = 2.0
        let itemWidth = (UIScreen.main.bounds.width - (spacing * 4)) / 3
        layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
        layout.minimumInteritemSpacing = spacing
        layout.minimumLineSpacing = spacing
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(ImageCell.self, forCellWithReuseIdentifier: "ImageCell")
        collectionView.dataSource = self
        collectionView.delegate = self // Add delegate
        view.addSubview(collectionView)
        
        setupDataSource()
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, ImageItem>(collectionView: collectionView) {
            (collectionView: UICollectionView, indexPath: IndexPath, imageItem: ImageItem) -> UICollectionViewCell? in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as! ImageCell
            cell.imageUrl = imageItem.url
            return cell
        }
    }
    
    private func applySnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, ImageItem>()
        snapshot.appendSections([.main])
        snapshot.appendItems(viewModel.imageItems())
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PhotoGalleryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.imageModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        fatalError("This method should not be called. Use diffable data source instead.")
    }
}

extension PhotoGalleryViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let fullScreenViewModel = FullScreenImageViewModel(imageUrls: viewModel.imageModels.map { $0.url }, initialIndex: indexPath.item)
        let fullScreenViewController = FullScreenImageViewController(viewModel: fullScreenViewModel)
        navigationController?.pushViewController(fullScreenViewController, animated: true) // Navigate to full screen 
    }
}
