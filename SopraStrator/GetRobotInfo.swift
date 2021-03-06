//
//  GetRobotInfo.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 18/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation

func getRobotInfo(token: String, robotId: Int, onCompletion: @escaping ([(String, String)]) -> Void) {
    
    var robotInfo = [(String, String)]()
    
    //JSON Headers
    let url = URL(string: "https://platform.uipath.com/odata/Robots(" + String(robotId) + ")")
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    session.dataTask(with: request) {data, response, error  in
        /*let urlResponse = response as? HTTPURLResponse
        let statusCodeInt = urlResponse?.statusCode
        let statusCodeStr = String(statusCodeInt!)*/
        let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: AnyObject]
        //let jsonArray = json? ["value"] as! [[String:AnyObject]]
        
        
        robotInfo.append(("Machine: ", json? ["MachineName"] as! String))
        robotInfo.append(("Version: ", json? ["Version"] as! String))
        robotInfo.append(("Type: ", json? ["Type"] as! String))
        
        
        onCompletion(robotInfo)
        
        //print(statusCodeStr)
        
        }.resume()
    
}
