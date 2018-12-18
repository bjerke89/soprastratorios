//
//  GetProcessInfo.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 18/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation

func getProcessInfo(token: String, processId: String, onCompletion: @escaping ([(String, String)]) -> Void) {
    
    var processInfo = [(String, String)]()

    //Json Headers
    let url = URL(string: "https://platform.uipath.com/odata/Processes?$filter=Id%20eq%20%27" + processId + "%27")
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
        
        processInfo.append(("Description: ", jsonArray[0]["Description"] as! String))
        processInfo.append(("Author: ", jsonArray[0]["Authors"] as! String))
        processInfo.append(("Version: ", jsonArray[0]["Version"] as! String))
        
        onCompletion(processInfo)
        
    }.resume()
}
