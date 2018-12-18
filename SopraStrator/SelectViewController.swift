//
//  ThirdViewController.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 17/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import UIKit

class SelectViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var countrows: Int = robotInfo.count
        if pickerView == processPicker {
            countrows = self.processInfo.count
        }
        return countrows
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == robotPicker {
            let robotRow = robotInfo[row].name
            return robotRow
        } else if pickerView == processPicker {
            let processRow = processInfo[row]
            return processRow
        }
        
        return ""
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == robotPicker {
            robotValue.text = robotInfo[row].name
            robotId = robotInfo[row].id
            
            getRobotInfo(token: loginToken, robotId: robotInfo[row].id, onCompletion:  { (robotInfo) in
                print(robotInfo as Any)
                self.robotTableData = robotInfo
                
            })
            
        } else if pickerView == processPicker {
            processValue.text = processInfo[row]
            processId = processInfo[row]
            
            getProcessInfo(token: loginToken, processId: processInfo[row], onCompletion:  { (processInfo) in
                print(processInfo as Any)
                self.processTableData = processInfo
            })
            
            
        }
        self.view.endEditing(true)
    }
    
    
    
    @IBOutlet weak var robotValue: UITextField!
    @IBOutlet weak var processValue: UITextField!
    
    var loginToken = LoginViewController.GlobalToken.loginToken
    var robotInfo = LoginViewController.GlobalToken.robotInfo
    var processInfo = LoginViewController.GlobalToken.processInfo
    
    var robotPicker = UIPickerView()
    var processPicker = UIPickerView()
    
    var robotId = (Int)()
    var processId = (String)()
    var releaseKey = (String)()
    var robotTableData = [(String, String)]()
    var processTableData = [(String, String)]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        robotValue.inputView = robotPicker
        robotPicker.delegate = self
        robotPicker.dataSource = self
        
        processValue.inputView = processPicker
        processPicker.delegate = self
        processPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func logoutClick(_ sender: Any) {
        performSegue(withIdentifier: "logout", sender: self)
    }
    
    @IBAction func startJobClick(_ sender: Any) {
        let processId = processValue.text!
        print("Robot Id: " + String(robotId))
        
        getReleaseKey(token: loginToken, processId: processId, onCompletion: { (releaseKey) in
            
            SopraStrator.startJob(token: self.loginToken, robotId: self.robotId, releasKey: releaseKey, onCompletion: { (response) in
                print(response as Any)
            }, onError: { (error) in
                print(error["message"] as! String)
            })
        })
    }
    
    @IBAction func robotInfoClick(_ sender: Any) {
        displayRobotPopup(roboInfo: robotTableData)
    }
    
    @IBAction func processInfoClick(_ sender: Any) {
        displayProcessPopup(processInfo: processTableData)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
