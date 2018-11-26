//
//  UIViewControllerExtensions.swift
//  Habitual
//
//  Created by Ryan Nguyen on 11/25/18.
//  Copyright © 2018 Danh Phu Nguyen. All rights reserved.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        return self.init(nibName: String(describing: self), bundle: nil)
    }
}
