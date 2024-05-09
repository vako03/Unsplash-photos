//
//  PhotoGalleryViewModel.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//

import Foundation

class PhotoGalleryViewModel {
    var imageModels: [ImageModel] = []
    
    func fetchImages(completion: @escaping () -> Void) {
        let photoAPIManager = PhotoAPIManager()
        photoAPIManager.fetchImages { [weak self] imageUrls in
            self?.imageModels = imageUrls.map { ImageModel(url: $0) }
            completion()
        }
    }
    
    func imageURL(at index: Int) -> String? {
        guard index >= 0, index < imageModels.count else {
            return nil
        }
        return imageModels[index].url
    }
    
    func imageItems() -> [ImageItem] {
        return imageModels.map { ImageItem(id: $0.url, url: $0.url) }
    }
}
