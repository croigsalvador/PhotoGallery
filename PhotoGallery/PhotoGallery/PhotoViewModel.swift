//
//  PhotoViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoViewModel: NSObject {
    
    var images : [String]?

    func cellViewModel(_ indexPath: IndexPath) -> ImagePresentable {
        var cellViewModel = PhotoCellViewModel()
        guard let images = images else {
            return cellViewModel
        }
        cellViewModel.imageName = images[indexPath.item]
        return cellViewModel
    }
    
    func numberOfItems(_ section: Int) -> Int {
        guard let images = images else {
            return 0
        }
        return images.count
    }
    
}
