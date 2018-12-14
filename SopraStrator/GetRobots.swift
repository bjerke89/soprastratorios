//
//  GetRobots.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 12/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation

func getRobots(token: String, onCompletion: @escaping ([(name: String,id: Int)]) -> Void) {
    
    var robotInfo = [(name: String,id: Int)]()
    
    //JSON Headers
    let url = URL(string: "https://platform.uipath.com/odata/Robots")
    var request = URLRequest(url: url!)
    request.httpMethod = "GET"
    request.setValue("Bearer " + token, forHTTPHeaderField: "Authorization")
    
    let session = URLSession.shared
    session.dataTask(with: request) {data, response, error  in
        let urlResponse = response as? HTTPURLResponse
        let statusCodeInt = urlResponse?.statusCode
        let statusCodeStr = String(statusCodeInt!)
        let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as! [String: AnyObject]
        let jsonArray = json? ["value"] as! [[String:AnyObject]]

        
        jsonArray.forEach { robot in
            robotInfo.append((robot["Name"] as! String,robot["Id"] as! Int))
        }
    
        onCompletion(robotInfo)
        
        //print(statusCodeStr)
    
    }.resume()

}
