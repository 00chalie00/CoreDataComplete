//
//  UIViewControllerExt.swift
//  CoreData
//
//  Created by formathead on 03/07/2019.
//  Copyright © 2019 formathead. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func presentDetail(_ viewContriller: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        present(viewContriller, animated: false, completion: nil)
    }
    
    func dismissDetail() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromLeft
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        dismiss(animated: false, completion: nil)
    }
    
    func dismisSecondary(finalVC: UIViewController) {
        let transition = CATransition()
        transition.duration = 0.0
        transition.type = .push
        transition.subtype = .fromRight
        self.view.window?.layer.add(transition, forKey: kCATransition)
        
        guard let presentedVC = presentedViewController else {return}
        
        presentedVC.dismiss(animated: false) {
            self.view.window?.layer.add(transition, forKey: kCATransition)
            self.present(finalVC, animated: false, completion: nil)
        }
        
    }
    
    
}//End Of The Extension
