//
//  MainViewController.swift
//  Habitual
//
//  Created by Ryan Nguyen on 11/25/18.
//  Copyright © 2018 Danh Phu Nguyen. All rights reserved.
//

import UIKit

class HabitsTableViewController: UITableViewController {
    
    var habits: [Habit] = [
        Habit(title: "Go to bed before 10pm", image: Habit.Images.book),
        Habit(title: "Drink 8 glasses of Water", image: Habit.Images.book),
        Habit(title: "Commit Today!", image: Habit.Images.book),
        Habit(title: "Stand up every hour", image: Habit.Images.book)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
//        setupNavBar()
        
        tableView.register(
            HabitTableViewCell.nib,
            forCellReuseIdentifier: HabitTableViewCell.identifier
        )
  
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return habits.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HabitTableViewCell.identifier, for: indexPath) as! HabitTableViewCell
        
        let habit = habits[indexPath.row]
        cell.configure(habit)
        return cell
    }
}

//extension HabitsTableViewController {
//    func setupNavBar() {
//        title = "Habitual"
//        let addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(pressAddHabit(_:)))
//        navigationItem.rightBarButtonItem = addButton
//        navigationItem.leftBarButtonItem = addButton
//    }
//    
//    @objc func pressAddHabit(_ sender: UIBarButtonItem) {
//        names.insert("YÜÜT", at: 0)
//        let topIndexPath = IndexPath(row: 0, section: 0)
//        tableView.insertRows(at: [topIndexPath], with: .automatic)
//    }
//}


