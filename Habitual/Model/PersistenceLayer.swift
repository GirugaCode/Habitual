//
//  PersistenceLayer.swift
//  Habitual
//
//  Created by Ryan Nguyen on 11/29/18.
//  Copyright © 2018 Danh Phu Nguyen. All rights reserved.
//

import Foundation

struct PersistenceLayer {
    // MARK: -VARS
    
    private(set) var habits: [Habit] = []
    
    private static let userDefaultsHabitsKeyValue = "HABITS_ARRAY"
    
    private mutating func loadHabits() {
        let userDefaults = UserDefaults.standard
        
        guard
            let habitData = userDefaults.data(forKey: PersistenceLayer.userDefaultsHabitsKeyValue),
            let habits = try? JSONDecoder().decode([Habit].self, from: habitData) else {
                return
        }
        self.habits = habits
    }
    
    // create and save habits
    @discardableResult
    
    mutating func createNewHabit(name: String, image: Habit.Images) -> Habit {
        
        let newHabit = Habit(title: name, image: image)
        self.habits.insert(newHabit, at: 0) //Prepends the items to the array
        self.saveHabits()
        
        return newHabit
    }
    
    //save
    private func saveHabits() {
        guard let habitsData = try? JSONEncoder().encode(self.habits) else {
            fatalError("could not encode list of habits")
        }
        let userDefaults = UserDefaults.standard
        userDefaults.set(habitsData, forKey: PersistenceLayer.userDefaultsHabitsKeyValue)
        
    }
    
    //delete
    mutating func delete(_ habitIndex: Int) {
        // Remove habit at the given index
        self.habits.remove(at: habitIndex)
        
        // Persist the changes we made to our habits array
        self.saveHabits()
    }
    
    // Mark Habit Complete
    
    mutating func markHabitAsCompleted(_ habitIndex: Int) -> Habit {
        
        var updatedHabit = self.habits[habitIndex]
        
        guard updatedHabit.hasCompletedForToday == false else { return updatedHabit }
        
        updatedHabit.numberOfCompletions += 1
        
        if let lastCompletionDate = updatedHabit.lastCompletionDate, lastCompletionDate.isYesterday {
            updatedHabit.currentStreak += 1
        } else {
            updatedHabit.currentStreak = 1
        }
        
        if updatedHabit.currentStreak > updatedHabit.bestStreak {
            updatedHabit.bestStreak = updatedHabit.currentStreak
        }
        
        let now = Date()
        updatedHabit.lastCompletionDate = now
        
        self.habits[habitIndex] = updatedHabit
        self.saveHabits()
        
        return updatedHabit
    }
    
    //swap habits
    
    mutating func swapHabits(habitIndex: Int, destinationIndex: Int) {
        let habitToSwap = self.habits[habitIndex]
        self.habits.remove(at: habitIndex)
        self.habits.insert(habitToSwap, at: destinationIndex)
        self.saveHabits()
    }
    mutating func setNeedsToReloadHabits() {
        self.loadHabits()
    }
    
    init() {
        self.loadHabits()
    }
}
