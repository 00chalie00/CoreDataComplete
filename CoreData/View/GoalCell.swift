//
//  GoalCell.swift
//  CoreData
//
//  Created by formathead on 03/07/2019.
//  Copyright © 2019 formathead. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    //Outlets
    
    @IBOutlet weak var goalDescriptionTxt: UILabel!
    @IBOutlet weak var goalTypeTxt: UILabel!
    @IBOutlet weak var goalPointTxt: UILabel!
    @IBOutlet weak var completeView: UIView!
    
    
    func configureCell(goal: GoalStudy ) {
        self.goalDescriptionTxt.text = goal.goalDescription
        self.goalTypeTxt.text = goal.goalType
        self.goalPointTxt.text = String(describing: goal.goalPoint)
        
        if goal.goalPoint == goal.goalCompleteValue {
            completeView.isHidden = false
        } else {
            completeView.isHidden = true
        }
    }
    
}//End Of The Class
