//
//  UIButtonExt.swift
//  CoreDataStudy
//
//  Created by formathead on 04/07/2019.
//  Copyright © 2019 formathead. All rights reserved.
//

import UIKit

extension UIButton {
    func isSenected() {
        self.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    }
    
    func isNotSelected() {
        self.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    }
}//End Of The Extension
