//
//  GoalVC.swift
//  CoreData
//
//  Created by formathead on 03/07/2019.
//  Copyright © 2019 formathead. All rights reserved.
//

import UIKit
import CoreData

let appDelegate = UIApplication.shared.delegate as? AppDelegate

class GoalVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var goals: [GoalStudy] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchCoreData()
        tableView.reloadData()
    }

    @IBAction func addGoalBtnWasPressed(_ sender: Any) {
        guard let createVC = storyboard?.instantiateViewController(withIdentifier: "createVC") as? CreateGoalVC else {return}
        
        presentDetail(createVC)
    }
    
    func fetchCoreData() {
        self.fetch { (success) in
            if success {
                if goals.count >= 1 {
                    tableView.isHidden = false
                } else {
                    tableView.isHidden = true
                }
            }
        }
    }
    
}//End Of The Class

extension GoalVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "goalCell", for: indexPath) as? GoalCell else {return UITableViewCell()}
        let tableData = goals[indexPath.row]
        cell.configureCell(goal: tableData)
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
//        let deleteAC = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            self.delete(indexPath: indexPath)
//            self.fetchCoreData()
//
//            //deleteRow Method 주의
//            tableView.deleteRows(at: [indexPath], with: .automatic)
//        }
//        deleteAC.backgroundColor = UIColor.red
//
//        return [deleteAC]
//    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, success: (Bool) -> Void) in
            self.delete(indexPath: indexPath)
            self.fetchCoreData()
            tableView.deleteRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        let add = UIContextualAction(style: .normal, title: "Add") { (action, view, success: (Bool) -> ()) in
            self.addProgress(indexPath: indexPath)
            tableView.reloadRows(at: [indexPath], with: .automatic)
            success(true)
        }
        
        delete.backgroundColor = UIColor.red
        add.backgroundColor = UIColor.purple
        return UISwipeActionsConfiguration(actions: [delete, add])
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    
}//End of The Extension

extension GoalVC {
    func fetch(completion: (_ success: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let fetchRequest = NSFetchRequest<GoalStudy>(entityName: "GoalStudy")
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completion(true)
            print("Successfully Fetched Data")
        } catch {
            completion(false)
            debugPrint("Could not fetched Data: \(error.localizedDescription)")
        }
    }
    
    func delete(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        managedContext.delete(goals[indexPath.row])
        do {
            try managedContext.save()
            print("Successfully Delete & Save")
        } catch {
            debugPrint("Could not saved: \(error.localizedDescription)")
        }
    }
    
    func addProgress(indexPath: IndexPath) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let selectIndex = goals[indexPath.row]
        if selectIndex.goalPoint < selectIndex.goalCompleteValue {
            selectIndex.goalPoint = selectIndex.goalPoint + 1
        } else {
            return
        }
        
        do {
            try managedContext.save()
            print("progress is added")
        } catch {
            debugPrint("Could not added progress")
        }
    }
    
}//End of The Extension
