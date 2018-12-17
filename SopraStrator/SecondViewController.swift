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
    
    @IBOutlet weak var robotPicker: UIPickerView!
    @IBOutlet weak var processPicker: UIPickerView!
    
    var loginToken = ViewController.GlobalToken.loginToken
    var robotInfo = ViewController.GlobalToken.robotInfo
    var processInfo = ViewController.GlobalToken.processInfo
    
    var selectedProcess = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        robotPicker.delegate = self
        robotPicker.dataSource = self
        
       processPicker.delegate = self
       processPicker.dataSource = self
        // Do any additional setup after loading the view.
    }
    
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
    
    
    @IBAction func logout(_ sender: Any) {
        
        performSegue(withIdentifier: "logout", sender: self)
        
    }
    
    
    @IBAction func startJob(_ sender: Any) {
        func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            
        }
        
    }
    
    
}
