//
//  StartJob.swift
//  SopraStrator
//
//  Created by Nicholas Bjerke on 14/12/2018.
//  Copyright © 2018 Nicholas Bjerke. All rights reserved.
//

import Foundation
import UIKit

func getReleaseKey(token: String, processId: String, onCompletion: @escaping (String) -> Void) {
    
    var releaseKey = ""
    
    //JSON Header
    
    let url = URL(string: "https://platform.uipath.com/odata/Releases?$filter=ProcessKey%20eq%20%27" + processId + "%27")
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
        
        releaseKey = jsonArray[0]["Key"] as! String
       
        onCompletion(releaseKey)
        
    }.resume()
}

