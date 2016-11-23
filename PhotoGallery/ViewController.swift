//
//  ViewController.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func openGalleryButtonPressed(_ sender: UIButton) {
        self.navigationController?.pushViewController(PhotoGalleryListViewController(PhotoGalleryListViewModel()), animated: true)
    }
}

