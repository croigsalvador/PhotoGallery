//
//  Router.swift
//  PhotoGallery
//
//  Created by Carlos Roig on 23/11/16.
//  Copyright © 2016 minube. All rights reserved.
//

import Foundation
import UIKit

enum Navigation {
    case push
    case pop
    case present
    case dismiss
}

protocol Router {
    func navigate(to viewModel: ViewModel, with navigation: Navigation)
}
