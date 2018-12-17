//
//  StartJob.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 17/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation
import UIKit

func startJob(token: String, robotId: Int, releasKey: String, onCompletion: @escaping ([String: Any]) -> Void, onError: @escaping ([String: Any]) -> Void) {
    
    //var robotIds = [(Int)]()
    //robotIds.append(robotId)
    
    //JSON Data
    
    let jsonData = ["startInfo": [
    "ReleaseKey": releasKey,
    "RobotIds": [robotId],
    "NoOfRobots": "0",
    "Strategy": "Specific"]] as [String : Any]
    
    let url = URL(string: "https://platform.uipath.com/odata/Jobs/UiPath.Server.Configuration.OData.StartJobs")
    var request = URLRequest(url: url!)
    request.httpMethod = "Post"
    request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    
    //Create body with JSON data
    let httpBody = try? JSONSerialization.data(withJSONObject: jsonData, options: [])
    request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
    request.httpBody = (httpBody as Data?)
    
    
    let session = URLSession.shared
    session.dataTask(with: request) { (data, response, error) in
        let urlResponse = response as? HTTPURLResponse
        let statusCodeInt = urlResponse?.statusCode
        let statusCodeStr = String(statusCodeInt!)
        let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: Any]
        
        if statusCodeStr == "201" {
            onCompletion((json)!)
        } else {
            onError((json)!)
        }
        
    }.resume()
    
}
