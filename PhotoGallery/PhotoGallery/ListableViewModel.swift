//
//  ListableViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation
import UIKit

protocol ListableViewModel {
    func numberOfItems(_ section : Int)
    func cellViewModel(_ indexPath : IndexPath)
}

protocol ListableCellViewModel {
    func image() -> UIImage
    func size() -> CGSize
}
