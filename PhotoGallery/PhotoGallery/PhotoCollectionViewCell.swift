//
//  PhotoCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {

    @IBOutlet weak var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.photoImageView.image = nil
    }
    func configure(_ viewModel : ImagePresentable) {
        viewModel.image(frame.size) { (image) in
            self.photoImageView.image = image
        }
        self.photoImageView.contentMode = viewModel.contentMode
    }

}
