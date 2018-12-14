//
//  HTTP Request Functions.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 10/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation
import JavaScriptCore


func authenticate (username :String, password: String, onCompletion: @escaping (String) -> Void, onError: @escaping (String) -> Void) {
    
    var token = ""
    var errorJson = ""
    
    //JSON DATA
    let jsonData: [String: Any] = [
        "tenancyName": "nbjerkeSopraSteria",
        "usernameOrEmailAddress": username,
        "password": password
    ]
    
    let url = URL(string: "https://platform.uipath.com/api/account/")
    var request = URLRequest(url: url!)
    request.httpMethod = "POST"
    
    //Create body with JSON data
    let httpBody = try? JSONSerialization.data(withJSONObject: jsonData, options: [])
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = httpBody
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        let urlResponse = response as? HTTPURLResponse
        let statusCodeInt = urlResponse?.statusCode
        let statusCodeStr = String(statusCodeInt!)
        let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: Any]
        
        if statusCodeStr == "200" {
            token = json? ["result"] as! String
            //print(token)
            onCompletion(token)
            
        } else {
            errorJson = json? ["message"] as! String
            onError(errorJson)
        }
        
    }.resume()
    
}

