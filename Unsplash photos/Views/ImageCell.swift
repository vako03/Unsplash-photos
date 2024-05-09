//
//  Cell.swift
//  Unsplash photos
//
//  Created by valeri mekhashishvili on 08.05.24.
//
import UIKit

class ImageCell: UICollectionViewCell {
    var imageView: UIImageView!
    var imageUrl: String? {
        didSet {
            if let url = imageUrl {
                imageView.loadImage(from: url)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        contentView.addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
