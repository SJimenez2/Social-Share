//
//  ViewController.swift
//  Social Share
//
//  Created by Sam Jimenez and Andrew Jones on 11/1/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit
import Contacts

class MainScreen: UIViewController {
    
    let defaults = UserDefaults.standard
    var userInfo = UserInfo()
    var generalInfo = GeneralInfo()
    var info: UserInfo?
    var qrString = ""
    var handle: [Handle] = []
    
    var friendFName: String = ""
    var friendLName: String = ""
    var friendPhone: String = ""
    var friendEmail = ""
    var friendHandles: [String] = []
    
    var setAddVisible = false
    let blurEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    @IBOutlet weak var addFacebook: UIButton!
    @IBOutlet weak var addInstagram: UIButton!
    @IBOutlet weak var addTwitter: UIButton!
    @IBOutlet weak var addScreen: UIView!
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var QRCodeImage: UIImageView!
    
    @IBAction func doneAdding(_ sender: UIButton) {
        addScreen.isHidden = true
        blurEffectView.isHidden = true
        view.backgroundColor = UIColor.init(red: 99/255, green: 0/255, blue: 101/255, alpha: 1)
    }
    @IBAction func addContact(_ sender: UIButton) {
        let contact = CNMutableContact()
        contact.givenName = friendFName
        print(contact.givenName)
        contact.familyName = friendLName
        print(contact.familyName)
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue: friendPhone))]
        contact.emailAddresses = [CNLabeledValue(label:CNLabelHome, value: (friendEmail as NSString))]
        
        // Saves contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier:nil)
        try! store.execute(saveRequest)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if !setAddVisible {
            addScreen.isHidden = true
            blurEffectView.isHidden = true
        } else {
            if !UIAccessibilityIsReduceTransparencyEnabled() {
                addBlur()
            }
        }
        if friendHandles.count > 0 {
            if friendHandles[0] == "" {
                addFacebook.isEnabled = false
            }
        
            if friendHandles[1] == "" {
                addInstagram.isEnabled = false
            }
        
            if friendHandles[2] == "" {
                addTwitter.isEnabled = false
            }
        }
        
        addScreen.layer.cornerRadius = 5
        addScreen.layer.masksToBounds = true
        
        info = (NSKeyedUnarchiver.unarchiveObject(withFile: UserDefaults.standard.object(forKey: "File Path") as! String) as! UserInfo)
        qrString = generalInfo.createQRString(user: info!)
        createQRCode(qrString: qrString)
    }
    
    func createQRCode(qrString: String){
        let data = qrString.data(using: .ascii, allowLossyConversion: false)
        let filter = CIFilter(name: "CIQRCodeGenerator")
        filter?.setValue(data, forKey: "inputMessage")
        let transform = CGAffineTransform(scaleX: 10, y:10)
        let image = UIImage(ciImage: (filter?.outputImage!.transformed(by: transform))!)
        QRCodeImage.image = image
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "quickEditInfo" {
            let vc = segue.destination as! SharingInfo
            vc.mainScreen = self
            
        } else if segue.identifier == "facebook" {
            let vc = segue.destination as! inAppWeb
            let username: String = friendHandles[0]
            vc.website = "https://www.facebook.com/\(username)"
            
        } else if segue.identifier == "twitter" {
            let vc = segue.destination as! inAppWeb
            let username: String = friendHandles[1]
            vc.website = "https://www.twitter.com/\(username)"
            
        } else if segue.identifier == "instagram" {
            let vc = segue.destination as! inAppWeb
            let username: String = friendHandles[2]
            vc.website = "https://www.instagram.com/\(username)"
            
        } else if segue.identifier == "editInfo" {
            let vc = segue.destination as! GeneralInfo
            vc.userInfo = self.info!
            vc.editingUser = true
            for i in 0..<3 {
                var platform = ""
                if i == 0 {
                    platform = "Facebook"
                } else if i == 1 {
                    platform = "Twitter"
                } else {
                    platform = "Instagram"
                }
                if info?.handles[i] != "" {
                    handle.append(Handle.init(handle1: (info?.handles[i])!, platform1: platform))
                }
            }
            vc.handles = handle
        }
    }
    
    func addBlur() {
        view.backgroundColor = UIColor.init(red: 62/255, green: 0/255, blue: 63/255, alpha: 1)
        
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        view.bringSubview(toFront: addScreen)
    }
    
    func saveRecievedInfo(info: String){
        // sort once shared
        let theirInfo = info.components(separatedBy: ",")
        
        friendFName = theirInfo[0]
        
        friendLName = theirInfo[1]
        
        friendPhone = theirInfo[2]
        
        friendEmail = theirInfo[3]
        
        friendHandles.append(theirInfo[4])
        friendHandles.append(theirInfo[5])
        friendHandles.append(String(theirInfo[6].dropLast()))
    }
}

