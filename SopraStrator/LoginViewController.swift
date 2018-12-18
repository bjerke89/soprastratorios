//
//  ViewController.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 07/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import UIKit
import Foundation
import JavaScriptCore

class LoginViewController: UIViewController {

    class GlobalToken {
        static var loginToken = String()
        static var robotInfo = [(name: String, id: Int)]()
        static var processInfo = [String]()
    }
    
    var loginSuccess = false
    var errorMessage = String()
    
    
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var tenantTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    //Run login function
    @IBAction func loginClicked(_ sender: Any) {
        
        let tenant   = tenantTextField.text!
        let username = usernameTextField.text!
        let password = passwordTextField.text!
        
    
        authenticate(tenant: tenant, username: username, password: password, onCompletion: { (token) in
            GlobalToken.loginToken = token
            self.loginSuccess = true
            
            getRobots(token: GlobalToken.loginToken, onCompletion: { (robotArr) in
                GlobalToken.robotInfo = robotArr
            })
            
            getProcesses(token: GlobalToken.loginToken, onCompletion: { (processArr) in
                GlobalToken.processInfo = processArr
                
                DispatchQueue.main.async {
                    self.displayLoginPopup(loginStatus: self.loginSuccess, error: self.errorMessage)
                }
                
            })
            
            
        }, onError: { (error) in
            self.errorMessage = error
            self.loginSuccess = false
            DispatchQueue.main.async {
                self.displayLoginPopup(loginStatus: self.loginSuccess, error: self.errorMessage)
            }
        })
      
        
    }
    
}
