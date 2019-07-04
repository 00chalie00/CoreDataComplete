//
//  CreateGoalVC.swift
//  CoreData
//
//  Created by formathead on 03/07/2019.
//  Copyright © 2019 formathead. All rights reserved.
//

import UIKit
import CoreData

class CreateGoalVC: UIViewController, UITextViewDelegate {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var shortBtn: UIButton!
    @IBOutlet weak var lognBtn: UIButton!
    
    var goalType: Goaltype = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
        nextBtn.bindKeyboard()
        tapGesture()
    }
    

    @IBAction func backBtnWasPressed(_ sender: Any) {
        dismissDetail()
    }
    
    @IBAction func shortTermBtnWasPressed(_ sender: Any) {
        goalType = .shortTerm
        shortBtn.isSenected()
        lognBtn.isNotSelected()
    }
    
    @IBAction func lognTermBtnWasPressed(_ sender: Any) {
        goalType = .longTerm
        shortBtn.isNotSelected()
        lognBtn.isSenected()
    }
    
    @IBAction func nextBtnWasPressed(_ sender: Any) {
        if textField.text != "" && textField.text != "What is your goal?" {
            guard let finishVC = storyboard?.instantiateViewController(withIdentifier: "finishVC") as? FinishGoalVC else {return}
            finishVC.finishInit(description: textField.text, term: goalType)
            
            presentDetail(finishVC)
            //presentingViewController?.dismisSecondary(finalVC: finishVC)
        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textField.text = ""
        textField.textColor = UIColor.blue
    }
    
    func tapGesture() {
        let tapGes = UITapGestureRecognizer(target: self, action: #selector(tapped(_:)))
        self.view.addGestureRecognizer(tapGes)
    }
    
    @objc func tapped(_ tapGesture: UITapGestureRecognizer) {
        textField.endEditing(true)
    }
    
}//End Of The Class

