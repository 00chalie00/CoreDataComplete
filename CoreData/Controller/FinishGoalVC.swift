//
//  FinishGoalVC.swift
//  CoreData
//
//  Created by formathead on 03/07/2019.
//  Copyright © 2019 formathead. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var completeValueTxt: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    
    var goalDescription: String!
    var goalTerm: Goaltype!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        completeValueTxt.delegate = self
        createBtn.bindKeyboard()
        tapGesture()
    }
    
    func finishInit(description: String, term: Goaltype) {
        self.goalDescription = description
        self.goalTerm = term
    }
    
    
    @IBAction func backBtnWasPressed(_ sender: Any) {
       dismissDetail()
    }
    
    
    @IBAction func createBtnWasPressed(_ sender: Any) {
        if completeValueTxt.text != "" {
            dataSave { (success) in
                if success {
                    //dismiss(animated: true, completion: nil)
                    presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
                }
            }
        }
    }
    
    func dataSave(completion: (_ success: Bool) -> ()) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {return}
        
        let goal = GoalStudy(context: managedContext)
        
        goal.goalCompleteValue = Int32(completeValueTxt.text!)!
        goal.goalDescription = goalDescription
        goal.goalType = goalTerm.rawValue
        goal.goalPoint = Int32(0)
        
        do {
            try managedContext.save()
            completion(true)
            print("Successfully Saved")
        } catch {
            completion(false)
            print("Could not saved: \(error.localizedDescription)")
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        completeValueTxt.text = ""
        completeValueTxt.textColor = UIColor.green
    }
    
    func tapGesture() {
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        self.view.addGestureRecognizer(tapGes)
    }
    
    @objc func tapped(_ gesture: UITapGestureRecognizer) {
        completeValueTxt.endEditing(true)
    }
    
}//End Of The Class

