//
//  SecondViewController.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 14/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import UIKit
import Foundation

class SecondViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
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
            robotLabel.text = robotInfo[row].name
        robotId = robotInfo[row].id
        
        } else if pickerView == processPicker {
            processLabel.text =  processInfo[row]
            processId = processInfo[row]
            
        }
    }
    
    
    @IBOutlet weak var robotPicker: UIPickerView!
    @IBOutlet weak var processPicker: UIPickerView!
    @IBOutlet weak var robotLabel: UILabel!
    @IBOutlet weak var processLabel: UILabel!
    
    var loginToken = ViewController.GlobalToken.loginToken
    var robotInfo = ViewController.GlobalToken.robotInfo
    var processInfo = ViewController.GlobalToken.processInfo
    
    var robotId = (Int)()
    var processId = (String)()
    var releaseKey = (String)()
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        robotPicker.delegate = self
        robotPicker.dataSource = self
        
        processPicker.delegate = self
        processPicker.dataSource = self
        
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logout(_ sender: Any) {
        
        performSegue(withIdentifier: "logout", sender: self)
        
    }
    
    @IBAction func startJob(_ sender: Any) {
        
        let processId = processLabel.text!
        print("Robot Id: " + String(robotId))
        
        getReleaseKey(token: loginToken, processId: processId, onCompletion: { (releaseKey) in
            
            SopraStrator.startJob(token: self.loginToken, robotId: self.robotId, releasKey: releaseKey, onCompletion: { (response) in
                print(response as Any)
            }, onError: { (error) in
                print(error["message"] as! String)
            })
        })
    
    }
    
}
