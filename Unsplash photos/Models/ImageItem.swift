//
//  ImageItem.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 09.05.24.
//

import Foundation

enum Section {
    case main
}

struct ImageItem: Hashable {
    let id: String
    let url: String
}
