//
//  ThirdViewController.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 17/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return robotInfo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return robotInfo[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        robotText.text = robotInfo[row].name
    }
    
    @IBOutlet weak var robotText: UITextField!
    
    
    var loginToken = ViewController.GlobalToken.loginToken
    var robotInfo = ViewController.GlobalToken.robotInfo
    var processInfo = ViewController.GlobalToken.processInfo
    
    var robotPicker = UIPickerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        robotText.inputView = robotPicker
        robotPicker.delegate = self
        robotPicker.dataSource = self
    
        // Do any additional setup after loading the view.
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
