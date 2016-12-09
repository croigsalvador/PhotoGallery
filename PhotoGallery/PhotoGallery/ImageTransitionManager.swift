//
//  ImageTransitionManager.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class ImageTransitionManager: UIPercentDrivenInteractiveTransition, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
    private var presenting = false
    private var interactive = false
    
    private var dismissPicturePanGesture: UIPanGestureRecognizer!
    
    var sourceViewController: PhotoViewController! {
        didSet {
            self.dismissPicturePanGesture = UIPanGestureRecognizer()
            self.dismissPicturePanGesture.addTarget(self, action:#selector(self.handleOnstagePan(_:)))
            self.sourceViewController.view.addGestureRecognizer(self.dismissPicturePanGesture)
        }
    }
    
    // TODO: We need to complete this method to do something useful
    func handleOnstagePan(_ pan: UIPanGestureRecognizer){
        
        let translation = pan.translation(in: pan.view!)
        
        print("Translation \(translation) in view \(pan.view!)")
        
//        let poistion =  translation.y / pan.view!.bounds.height * 0.5
        
        // now lets deal with different states that the gesture recognizer sends
        switch (pan.state) {
            
        case UIGestureRecognizerState.began:
            // set our interactive flag to true
            self.interactive = true
            self.sourceViewController.startPopTransition()
            break
            
        case UIGestureRecognizerState.changed:
            
            // update progress of the transition
            updateImageTransition(translation)
            break
            
        default: // .Ended, .Cancelled, .Failed ...
            
            // return flag to false and finish the transition
            self.interactive = false
            //            self.finishInteractiveTransition()
        }
    }
    
    func updateImageTransition(_ translation: CGPoint) {
        
    }
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
    }
    
    // return how many seconds the transiton animation will take
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
    
    // MARK: UIViewControllerTransitioningDelegate protocol methods
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = true
        return self
    }
    
    // return the animator used when dismissing from a viewcontroller
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.presenting = false
        return self
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactive ? self : nil
    }
    
}

