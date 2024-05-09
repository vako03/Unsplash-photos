//
//  PhotoGalleryViewModel.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//

import Foundation

class PhotoGalleryViewModel {
    var imageModels: [ImageModel] = [] // Change access level to 'internal'
    
    func fetchImages(completion: @escaping () -> Void) {
        let photoAPIManager = PhotoAPIManager()
        photoAPIManager.fetchImages { [weak self] urls in
            self?.imageModels = urls.map { ImageModel(url: $0) }
            completion()
        }
    }
    
    func imageURL(at index: Int) -> String? {
        guard index >= 0, index < imageModels.count else {
            return nil
        }
        return imageModels[index].url
    }
}

