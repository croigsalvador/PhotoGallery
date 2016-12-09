//
//  PhotoViewController.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
    
    @IBOutlet fileprivate weak var collectionView: UICollectionView!
    fileprivate let viewModel : PhotoViewModel
    
    var transitionManager = ImageTransitionManager()
    
    init(_ viewModel : PhotoViewModel) {
        self.viewModel = viewModel
        super.init(nibName:"PhotoViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startPopTransition(){
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func selectedImageView() -> UIImageView? {
        let visibleCells = self.collectionView.visibleCells
        guard let cell = visibleCells.first as? PhotoCollectionViewCell else {
            return nil
        }
        return cell.photoImageView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.transitionManager.sourceViewController = self
        self.navigationController?.delegate = self
        self.setupCollectionView()
    }
    
    private func setupCollectionView() {
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
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

extension PhotoViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return self.collectionView.frame.size
    }
}

extension PhotoViewController : UINavigationControllerDelegate {
//    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//        return transitionManager
//    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            return transitionManager
        }
        return nil
    }
}


