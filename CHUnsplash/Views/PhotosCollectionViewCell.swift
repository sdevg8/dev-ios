//
//  PhotosCollectionViewCell.swift
//  CHUnsplash
//
//  Created by user on 14/03/21.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var photoImageView: UIImageView!
    static var identifier: String {
        return String(describing: self)
    }
    func configure(_ photo: Photos) {
        self.photoImageView.loadImageUsingCacheWithURLString(photo.thumbnailUrl, placeHolder: nil) { (bool) in
            //perform actions if needed
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
