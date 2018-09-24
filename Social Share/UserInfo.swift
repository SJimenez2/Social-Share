//
//  UserInfo.swift
//  Social Share
//
//  Created by Samuel Jimenez and Andrew Jones on 11/2/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import Foundation
import UIKit

class UserInfo: NSObject, NSCoding {
    var fname: String = ""
    var lname: String = ""
    var email: String = ""
    var phone: String = ""
    var handles: [String] = ["", "", ""]
    
    struct Keys {
        static let FName = "firstName"
        static let LName = "lastName"
        static let Email = "email"
        static let Phone = "phone"
        static let Handles = "Handles"
    }
    
    override init() {}
    
    init(fname1: String, lname1: String, phone1: String, email1: String, handlesArray: [Handle]) {
        self.fname = fname1
        self.lname = lname1
        self.phone = phone1
        self.email = email1
        
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
    
    //encoding objects (saving)
    func encode(with aCoder: NSCoder) {
        //save variables using key value pair
        aCoder.encode(fname, forKey: Keys.FName)
        aCoder.encode(lname, forKey: Keys.LName)
        aCoder.encode(email, forKey: Keys.Email)
        aCoder.encode(phone, forKey: Keys.Phone)
        aCoder.encode(handles, forKey: Keys.Handles)
    }
    
    //decode objects (loading)
    required init?(coder aDecoder: NSCoder) {
        //if you can decode an object under the key Keys._ , and if you can cast it as its initalized type
        if let fnameObj = aDecoder.decodeObject(forKey: Keys.FName) as? String {
            fname = fnameObj
        }
        if let lnameObj = aDecoder.decodeObject(forKey: Keys.LName) as? String {
            lname = lnameObj
        }
        if let emailObj = aDecoder.decodeObject(forKey: Keys.Email) as? String {
            email = emailObj
        }
        if let phoneObj = aDecoder.decodeObject(forKey: Keys.Phone) as? String {
            phone = phoneObj
        }
        if let handlesObj = aDecoder.decodeObject(forKey: Keys.Handles) as? [String] {
            handles = handlesObj
        }
    }
    
    func saveUserInfo (fname1: String, lname1: String, phone1: String, email1: String, facebook:String, instagram:String, twitter:String) {
        fname = fname1
        lname = lname1
        phone = phone1
        email = email1
        handles.append(facebook)
        handles.append(instagram)
        handles.append(twitter)
    }
    
    func print() {
        Swift.print("\(fname), \(lname), \(phone), \(email), \(handles[0]), \(handles[1]), \(handles[2])")
    }
}



