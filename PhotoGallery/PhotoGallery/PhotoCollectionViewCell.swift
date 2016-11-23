//
//  PhotoCollectionViewCell.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell, NibLoadableView, ReusableView {
    
    @IBOutlet private weak var photoImageView: UIImageView!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    override func prepareForReuse() {
        self.photoImageView.image = nil
    }
    
    func configureCell(_ viewModel : ListableCellViewModel){
        viewModel.image { (image) in
            self.photoImageView.image = image
        }
    }
}
