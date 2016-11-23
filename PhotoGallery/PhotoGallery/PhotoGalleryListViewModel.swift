//
//  PhotoGalleryListViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation

class PhotoGalleryListViewModel : ViewModel, ListableViewModel {
    
    private let cellViewModels = [PhotoCellViewModel("image1"),PhotoCellViewModel("image2"), PhotoCellViewModel("image3")]
    
    func cellViewModel(_ indexPath: IndexPath) -> ListableCellViewModel {
        return self.cellViewModels[indexPath.item]
    }
    
    func numberOfItems(_ section: Int) -> Int {
        return self.cellViewModels.count
    }

    
}
