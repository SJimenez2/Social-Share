//
//  ShareInfo.swift
//  Social Share
//
//  Created by Sam Jimenez and Andrew Jones on 12/8/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import Foundation
import UIKit

class SharingInfo: UIViewController {
    
    
    @IBOutlet weak var Email: UISwitch!
    @IBOutlet weak var Facebook: UISwitch!
    @IBOutlet weak var Twitter: UISwitch!
    @IBOutlet weak var Instagram: UISwitch!
    
    var firstName = ""
    var lastName = ""
    var phone = ""
    var email = ""
    var handles: [Handle] = []
    
    var userInfo = UserInfo()
    var generalInfo = GeneralInfo()
    var mainScreen = MainScreen()
    
    override func viewDidLoad() {
        checkEnabledSwitches()
        disableSwitches()
    }
    
    func disableSwitches() {
        let user = NSKeyedUnarchiver.unarchiveObject(withFile: UserDefaults.standard.object(forKey: "File Path") as! String) as? UserInfo
        if user?.email == "" {
            Email.isEnabled = false
        }
        if user?.handles[0] == "" {
            Facebook.isEnabled = false
        }
        if user?.handles[1] == "" {
            Twitter.isEnabled = false
        }
        if user?.handles[2] == "" {
            Instagram.isEnabled = false
        }
    }
    
    func checkEnabledSwitches() {
        let info = UserDefaults.standard.object(forKey: "SharedInfo") as! String
        let theirInfo = info.components(separatedBy: ",")
        
        Email.setOn(theirInfo[3] == "", animated: false)
        Facebook.setOn(theirInfo[4] == "", animated: false)
        Twitter.setOn(theirInfo[5] == "", animated: false)
        Instagram.setOn(theirInfo[6].dropLast() == "", animated: false)

        
//        if theirInfo[3] == "" {
//            Email.setOn(false, animated: false)
//        }
//        if theirInfo[4] == "" {
//            Facebook.setOn(false, animated: false)
//        }
//        if theirInfo[5] == "" {
//            Twitter.setOn(false, animated: false)
//        }
//        if theirInfo[6].dropLast() == "" {
//            Instagram.setOn(false, animated: false)
//        }
    }
    
    //defaults to sending everything each time shared
    @IBAction func doneButton(_ sender: UIButton) {
        checkdata()
        
        let sharedUser = UserInfo()
        sharedUser.setData(fname: firstName, lname: lastName, phone: phone, email: email, handlesArray: handles)
        let qrString = generalInfo.createQRString(user: sharedUser)
        mainScreen.createQRCode(qrString: qrString)
        self.dismiss(animated: true, completion: nil)
    }
    
    func checkdata() {
        let user = NSKeyedUnarchiver.unarchiveObject(withFile: UserDefaults.standard.object(forKey: "File Path") as! String) as? UserInfo
        userInfo = user!
        
        firstName = (userInfo.fname)
        lastName = (userInfo.lname)
        phone = (userInfo.phone)
        
        if Email.isOn {
            email = (userInfo.email)
        }
        if Facebook.isOn {
            handles.append(Handle.init(handle1: userInfo.handles[0], platform1: "Facebook"))
        }
        if Twitter.isOn {
            handles.append(Handle.init(handle1: userInfo.handles[1], platform1: "Twitter"))
        }
        if Instagram.isOn {
            handles.append(Handle.init(handle1: userInfo.handles[2], platform1: "Instagram"))
        }
    }
}
