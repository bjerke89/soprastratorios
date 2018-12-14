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
            let titleRow = robotInfo[row].name
            return titleRow
        } else if pickerView == processPicker {
            let titlerow = processInfo[row]
            return titlerow
            }
            return ""
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
