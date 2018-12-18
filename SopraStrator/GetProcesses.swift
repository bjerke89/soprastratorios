//
//  GetProcesses.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 13/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation


func getProcesses(token: String, onCompletion: @escaping ([(String)]) -> Void) {
    
    var processInfo = [(String)]()
    
    //Json Headers
    let url = URL(string: "https://platform.uipath.com/odata/Processes")
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    session.dataTask(with: request) {data, response, error in
        /*let urlResponse = response as? HTTPURLResponse
        let statusCodeInt = urlResponse?.statusCode
        let statusCodeStr = String(statusCodeInt!)*/
        let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: AnyObject]
        let jsonArray = json? ["value"] as! [[String:AnyObject]]
        
        jsonArray.forEach { process in
            processInfo.append(process["Id"] as! String)
        }
        
        onCompletion(processInfo)
    }.resume()
}
