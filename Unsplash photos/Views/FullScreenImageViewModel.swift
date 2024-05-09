//
//  FullScreenImageViewModel.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//

class FullScreenImageViewModel {
    var imageUrls: [String] = []
    var initialIndex: Int
    
    init(imageUrls: [String], initialIndex: Int) {
        self.imageUrls = imageUrls
        self.initialIndex = initialIndex
    }
}
