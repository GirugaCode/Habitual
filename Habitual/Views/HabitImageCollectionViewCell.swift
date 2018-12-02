//
//  HabitImageCollectionViewCell.swift
//  Habitual
//
//  Created by Ryan Nguyen on 12/1/18.
//  Copyright © 2018 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class HabitImageCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "habit image cell"
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func setImage(image: UIImage){
        self.habitImage.image = image
    }


    @IBOutlet weak var habitImage: UIImageView!
    
}
