//
//  PhotoCellViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation
import UIKit

struct PhotoGridCellViewModel  {
    
    private let imageName : String
    
    init(_ imageName: String) {
        self.imageName = imageName
    }
    
    func size() -> CGSize {
        return CGSize(width:80.0, height:80.0)
    }
    
    func image(completion: (UIImage) -> ()) {
        completion(UIImage(named:self.imageName)!)
    }
}
