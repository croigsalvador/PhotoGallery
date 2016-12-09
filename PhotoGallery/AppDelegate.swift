//
//  AppDelegate.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        self.window?.rootViewController = UINavigationController(rootViewController:self.setupInitialViewController())
        self.window?.makeKeyAndVisible()
        
        return true
    }

    private func setupInitialViewController() -> UIViewController {
        let viewModel = PhotoGalleryListViewModel()
        return PhotoGalleryListViewController(viewModel)
    }

}

