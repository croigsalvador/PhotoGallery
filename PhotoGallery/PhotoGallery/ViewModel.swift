//
//  ViewModel.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation

protocol ViewModel {
    func viewDidLoad()
    func viewWillAppear()
}

extension ViewModel {
    func viewDidLoad(){}
    func viewWillAppear(){}
}
