//
//  DisplayRobotInfo.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 18/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func displayRobotPopup(roboInfo: [(String, String)]) {
        
        
        var robotInfoMessage = ""
       
        for info in roboInfo {
            robotInfoMessage = robotInfoMessage + info.0 + info.1 + "\n"
        }
        
            let alertController = UIAlertController(title: "Robot Info", message: robotInfoMessage, preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: { ACTION in
                
            }))
            
            self.present(alertController, animated: true, completion: nil)
            
        }
    }

