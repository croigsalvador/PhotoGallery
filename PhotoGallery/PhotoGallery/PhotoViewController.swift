//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {

    @IBOutlet private weak var collectionView: UICollectionView!
    fileprivate let viewModel : PhotoViewModel = PhotoViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.register(PhotoCollectionViewCell.self)
    }
}

extension PhotoViewController : UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PhotoCollectionViewCell = collectionView.dequeueReusableCell(forIndexPath: indexPath)
        let cellViewModel = self.viewModel.cellViewModel(indexPath)
        cell.configure(cellViewModel)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.numberOfItems(section)
    }
}

