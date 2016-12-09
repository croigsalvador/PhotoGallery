//
//  PhotoGalleryListViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation

class PhotoGalleryListViewModel : ViewModel {
    
    
    private let cellViewModels = [PhotoGridCellViewModel("image1"),PhotoGridCellViewModel("image2"), PhotoGridCellViewModel("image3")]
    
    func cellViewModel(_ indexPath: IndexPath) -> PhotoGridCellViewModel {
        return self.cellViewModels[indexPath.item]
    }
    
    func numberOfItems(_ section: Int) -> Int {
        return self.cellViewModels.count
    }
    
    func didSelectItem(at indexPath: IndexPath) {
        
    }

    
}
