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
    var generalInfo = GeneralInfo()
    var info: UserInfo?
    var qrString = ""
    var handle: [Handle] = []
    
    var friendHandles = [String : String]()
    var platforms: [String] = ["facebook", "twitter", "instagram"]
    
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
        contact.givenName = friendHandles["fName"]!
        print(contact.givenName)
        contact.familyName = friendHandles["lName"]!
        print(contact.familyName)
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue: friendHandles["phone"]!))]
        contact.emailAddresses = [CNLabeledValue(label:CNLabelHome, value: (friendHandles["email"]! as NSString))]
        
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
        
        if friendHandles["Facebook"] == "" {
            addFacebook.isEnabled = false
        }
    
        if friendHandles["Instagram"] == "" {
            addInstagram.isEnabled = false
        }
    
        if friendHandles["Twitter"] == "" {
            addTwitter.isEnabled = false
        }
        
        addScreen.layer.cornerRadius = 5
        addScreen.layer.masksToBounds = true
        
//        info = (NSKeyedUnarchiver.unarchiveObject(withFile: UserDefaults.standard.object(forKey: "File Path") as! String) as! UserInfo)
//        qrString = generalInfo.createQRString(user: info!)
        qrString = ""
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
            
        } else if segue.identifier == "editInfo" {
            let vc = segue.destination as! GeneralInfo
            vc.userInfo = self.info!
            vc.editingUser = true
            for i in 0..<3 {
                var platform = ""
                platform = platforms[i]
                if info?.handles[i] != "" {
                    handle.append(Handle.init(handle1: (info?.handles[i])!, platform1: platform))
                }
            }
            vc.handles = handle
        } else if segue.identifier == "facebook" ||
                  segue.identifier == "twitter" ||
                  segue.identifier == "instagram" {
            let vc = segue.destination as! inAppWeb
            let username: String = friendHandles[segue.identifier!]!
            vc.website = "https://www.\(segue.identifier!).com/\(username)"
            print(vc.website)
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
        
        friendHandles["fName"] = theirInfo[4]
        friendHandles["lName"] = theirInfo[1]
        friendHandles["phone"] = theirInfo[2]
        friendHandles["email"] = theirInfo[3]
        friendHandles["facebook"] = theirInfo[4]
        friendHandles["instagram"] = theirInfo[5]
        friendHandles["twitter"] = String(theirInfo[6].dropLast())
    }
}

