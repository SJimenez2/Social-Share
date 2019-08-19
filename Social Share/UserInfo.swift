//
//  UserInfo.swift
//  Social Share
//
//  Created by Samuel Jimenez and Andrew Jones on 11/2/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import Foundation
import UIKit

class UserInfo {
    var fname: String = ""
    var lname: String = ""
    var email: String = ""
    var phone: String = ""
    var handles: [String] = ["", "", ""]
    
    func setData(fname: String, lname: String, phone: String, email: String, handlesArray: [Handle]) {
        self.fname = fname
        self.lname = lname
        self.phone = phone
        self.email = email
        
        for i in 0..<handlesArray.count {
            if handlesArray[i].Image == #imageLiteral(resourceName: "Facebook Icon") {
                handles[0] = handlesArray[i].Handle
            } else if handlesArray[i].Image == #imageLiteral(resourceName: "Twitter Icon") {
                handles[1] = handlesArray[i].Handle
            } else if handlesArray[i].Image == #imageLiteral(resourceName: "Instagram Icon") {
                handles[2] = handlesArray[i].Handle
            }
        }
    }
    
    func print() {
        Swift.print("\(fname), \(lname), \(phone), \(email), \(handles[0]), \(handles[1]), \(handles[2])")
    }
}



