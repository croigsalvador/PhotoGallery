//
//  PhotoGalleryListViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation

class PhotoGalleryListViewModel : ViewModel {
    
    private let images = ["image1","image2","image3"]
    
    func cellViewModel(_ indexPath: IndexPath) -> PhotoGridCellViewModel {
        return PhotoGridCellViewModel(images[indexPath.item])
    }
    
    func numberOfItems(_ section: Int) -> Int {
        return self.images.count
    }

    func photoViewModel(_ index: Int) -> PhotoViewModel {
        let photoViewModel = PhotoViewModel()
        photoViewModel.images = images
        photoViewModel.selectedIndex = index
        return photoViewModel
    }
}
