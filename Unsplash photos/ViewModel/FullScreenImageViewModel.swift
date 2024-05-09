//
//  FullScreenImageViewModel.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//

import Foundation

class FullScreenImageViewModel {
    var imageUrls: [String] = []
    var currentPageIndex: Int
    
    init(imageUrls: [String], initialIndex: Int) {
        self.imageUrls = imageUrls
        self.currentPageIndex = initialIndex
    }
    
    func imageUrl(at index: Int) -> String? {
        guard index >= 0, index < imageUrls.count else {
            return nil
        }
        return imageUrls[index]
    }
}
