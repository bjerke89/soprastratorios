//
//  DisplayPopup.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 11/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

func displayPopup(loginStatus: Bool, error: String) {
    
    if (loginStatus == true) {
        let alertController = UIAlertController(title: "Login Status", message: "Login Successful", preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { ACTION in
            
            
            self.performSegue(withIdentifier: "PickView", sender: self)
        }))
        
        self.present(alertController, animated: true, completion: nil)
        
    } else {
        let alertController = UIAlertController(title: "Login Status", message: error, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { ACTION in
        }))

        
        self.present(alertController, animated: true, completion: nil)
        
        }
    }
}
