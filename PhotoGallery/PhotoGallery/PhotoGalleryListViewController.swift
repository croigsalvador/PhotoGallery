//
//  PhotoGalleryListViewController.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoGalleryListViewController: UIViewController {
    
    @IBOutlet private weak var collectionView: UICollectionView!
    
    fileprivate let viewModel : ListableViewModel
    
    init(_ viewModel : ListableViewModel) {
        self.viewModel = viewModel
        super.init(nibName:"PhotoGalleryListViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
    
    }
}

extension PhotoGalleryListViewController : UICollectionViewDataSource {
    
    
}
