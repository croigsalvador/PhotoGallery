//
//  PhotoCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoGridCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func prepareForReuse() {
        self.photoImageView.image = nil
    }
    
    func configureCell(_ viewModel : PhotoGridCellViewModel){
        viewModel.image { (image) in
            self.photoImageView.image = image
        }
    }
}
