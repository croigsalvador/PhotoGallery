//
//  ImageTransitionManager.swift
//  PhotoGallery
//
//  Created by Carlos Roig Salvador on 9/12/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

class ImageTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate  {
    
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
        guard let imageView = self.sourceViewController.selectedImageView() else {
            return
        }
        guard let startAnimationView = newAnimationView(imageView) else {
            return
        }
        
        let imageViewFrame = self.sourceViewController.view.convert(imageView.frame, from:imageView)
        
        startAnimationView.frame = CGRect(x: 0, y: translation.y + imageViewFrame.origin.y, width: startAnimationView.frame.width, height: startAnimationView.frame.height)
        
        print("Translation \(translation) in viewFrame \(imageViewFrame), imageview : \(imageView)")
        
    }
    
    func newAnimationView(_ view : UIView) -> UIView? {
        
        
        var animationView : UIView? = nil
        
        if (view.layer.contents != nil) {
            if view is UIImageView {
                // The case of UIImageView is handled separately since the mere layer's contents (i.e. CGImage in this case) doesn't
                // seem to contain proper informations about the image orientation for portrait images taken directly on the device.
                // See https://github.com/NYTimes/NYTPhotoViewer/issues/115
                let imageView = view as! UIImageView
                animationView = UIImageView(image:imageView.image)
                animationView?.bounds = view.bounds;
            }
            else {
                animationView = UIView(frame:view.frame);
                animationView?.layer.contents = view.layer.contents;
                animationView?.layer.bounds = view.layer.bounds;
            }
            
            animationView?.layer.cornerRadius = view.layer.cornerRadius;
            animationView?.layer.masksToBounds = view.layer.masksToBounds;
            animationView?.contentMode = view.contentMode;
            animationView?.transform = view.transform;
        }
        else {
            animationView = view.snapshotView(afterScreenUpdates: true)
        }
        
        return animationView
    }
    
    // MARK: UIViewControllerAnimatedTransitioning protocol methods
    
    // animate a change from one viewcontroller to another
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        
        guard let toView = transitionContext.view(forKey: UITransitionContextViewKey.to) ,
            let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to),
            let toScreenshot = captureScreenShot(view: toViewController.view),
            let actualImageView = sourceViewController.selectedImageView(),
            let actualImageScreenShot = snapshot(of: frame(for: actualImageView.image!, inAspectFit:actualImageView.frame), in: actualImageView)
            else {
                transitionContext.completeTransition(false)
                return
        }
        
        let container = transitionContext.containerView
        container.addSubview(toView)
        
        container.addSubview(toScreenshot)
    
        actualImageScreenShot.frame =  frame(for: actualImageView.image!, inAspectFit:actualImageView.frame)
        container.addSubview(actualImageScreenShot)
        
        var imageFinalFrame = actualImageScreenShot.frame
        imageFinalFrame.origin.y = toView.frame.size.height
        
        sourceViewController.view.alpha = 0.0;
        toView.alpha = 0.0
        toScreenshot.alpha = 0.0
        UIView.animate(withDuration: 0.5, animations: {
            actualImageScreenShot.frame = imageFinalFrame
            toScreenshot.alpha = 1.0
            toView.alpha = 1.0;
        }) { (finished) in
            toScreenshot.removeFromSuperview()
            actualImageScreenShot.removeFromSuperview()
            toView.alpha = 1.0;
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
    
    func captureScreenShot(view: UIView) -> UIImageView? {
        defer {
            UIGraphicsEndImageContext()
        }
        //Force render to get correct nib size from the view.
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        UIGraphicsEndImageContext()
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, UIScreen.main.scale)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else {
            return nil
        }
        return UIImageView(image: image)
    }
    
    func snapshot(of rect: CGRect, in view: UIView) -> UIImageView? {
        // snapshot entire view
        
        UIGraphicsBeginImageContextWithOptions(view.frame.size, true, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let wholeImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // if no `rect` provided, return image of whole view
        
        guard let image = wholeImage else { return nil }
        
        // otherwise, grab specified `rect` of image
        
        let scale = image.scale
        let scaledRect = CGRect(x: rect.origin.x * scale, y: rect.origin.y * scale, width: rect.size.width * scale, height: rect.size.height * scale)
        guard let cgImage = image.cgImage?.cropping(to: scaledRect) else { return nil }
        return UIImageView(image:UIImage(cgImage: cgImage, scale: scale, orientation: .up))
    }

    
    func frame(for image: UIImage, inAspectFit frame: CGRect) -> CGRect {
        let imageRatio = image.size.width / image.size.height;
        
        let viewRatio = frame.size.width / frame.size.height;
        
        if imageRatio < viewRatio {
            let scale = frame.size.height / image.size.height;
            
            let width = scale * image.size.width;
            
            let topLeftX = (frame.size.width - width) * 0.5;
            
            return CGRect(x:topLeftX, y:0, width:width, height:frame.size.height);
        } else {
            let scale = frame.size.width / image.size.width;
            
            let height = scale * image.size.height;
            
            let topLeftY = (frame.size.height - height) * 0.5;
            return CGRect(x:0, y:topLeftY, width:frame.size.width, height:height);
        }
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
    
    //    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //        return self.interactive ? self : nil
    //    }
    //
    //    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
    //        return self.interactive ? self : nil
    //    }
    
}

