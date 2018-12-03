//
//  AddHabitViewController.swift
//  Habitual
//
//  Created by Ryan Nguyen on 11/30/18.
//  Copyright © 2018 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class AddHabitViewController: UIViewController {
    
    let habitImages = Habit.Images.allCases


    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func pickPhotoButtonPressed(_ sender: UIButton) {
        guard let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first else {return}
        let confirmHabitVC = ConfirmHabitViewController.instantiate()
        confirmHabitVC.habitImage = habitImages[selectedIndexPath.row]
        navigationController?.pushViewController(confirmHabitVC, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(HabitImageCollectionViewCell.nib, forCellWithReuseIdentifier: HabitImageCollectionViewCell.identifier)
        
        collectionView.allowsMultipleSelection = false
        
        setupNavBar()

        // Do any additional setup after loading the view.
    }
    
    func setupNavBar() {
        title = "Select Image"
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelAddHabit(_:)))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func cancelAddHabit(_ sender: UIBarButtonItem) {
        
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}

extension AddHabitViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    // returns the number of cells
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return habitImages.count
    }
    
    // returns what is going to be inside the cell
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HabitImageCollectionViewCell.identifier, for: indexPath) as! HabitImageCollectionViewCell
        
        cell.setImage(image: habitImages[indexPath.row].image)
        
        return cell
    }
    
    // spacing between the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    // size of the cells
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/4, height: collectionViewWidth/4)
    }
    
    // indicated which cell has been selected
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.yellow.cgColor
    }
    
    // deselects the cell if pressed again
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 0.0
    }
    
    
}
