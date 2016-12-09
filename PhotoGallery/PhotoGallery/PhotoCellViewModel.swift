//
//  PhotoCellViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit
import SDWebImage

struct PhotoCellViewModel : ImagePresentable {
    var imageURL: URL?
    var imageName : String?
    var placeholder: String? {return ""}
    
   }

protocol ImagePresentable {
    var placeholder: String? {get}
    var imageURL: URL? {get}
    var imageName : String? {get}
    var contentMode: UIViewContentMode {get}
    func image (_ size: CGSize,completion: @escaping (UIImage?)->())
}

extension ImagePresentable {
    var placeholder: String? {return nil}
    var contentMode: UIViewContentMode {return .scaleAspectFit}
    
    func image(_ size: CGSize, completion: @escaping (UIImage?) -> ()) {
        guard let imageName = imageName else {
            completion(UIImage(named:placeholder!))
            return
        }
        completion(UIImage(named:imageName))
    }

}
