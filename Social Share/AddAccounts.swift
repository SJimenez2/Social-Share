//
//  AddAccounts.swift
//  Social Share
//
//  Created by Sam Jimenez and Andrew Jones on 11/6/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit
import Contacts

class AddAccounts: UIViewController {
    
    var friendFName: String = ""
    var friendLName: String = ""
    var friendPhone: String = ""
    var friendEmail = ""
    var friendHandles: [String] = []
    
    
    @IBOutlet weak var menuBox: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuBox.layer.cornerRadius = 5
        menuBox.layer.masksToBounds = true
    }
    
    @IBAction func addContact(_ sender: UIButton) {
        let contact = CNMutableContact()
        contact.givenName = friendFName
        contact.familyName = friendLName
        contact.phoneNumbers = [CNLabeledValue(
            label:CNLabelPhoneNumberiPhone,
            value:CNPhoneNumber(stringValue: friendPhone))]
        contact.emailAddresses = [CNLabeledValue(label:CNLabelHome, value: (friendEmail as NSString))]
        
        // Saves contact
        let store = CNContactStore()
        let saveRequest = CNSaveRequest()
        saveRequest.add(contact, toContainerWithIdentifier: nil)
        try! store.execute(saveRequest)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "addAccountsDone" {
            self.dismiss(animated: true, completion: nil)
            dismiss(animated: true, completion: nil)
        }
        
        if segue.identifier == "facebook" {
            let vc = segue.destination as! inAppWeb
            let username: String = friendHandles[0]
            
            vc.website = "https://www.facebook.com/\(username)"
        }
        
        if segue.identifier == "twitter" {
            let vc = segue.destination as! inAppWeb

            let username: String = friendHandles[1]
                
            vc.website = "https://www.twitter.com/\(username)"
        }
        
        if segue.identifier == "instagram" {
            let vc = segue.destination as! inAppWeb

            let username: String = friendHandles[2]
            
            vc.website = "https://www.instagram.com/\(username)"
        }
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
        friendHandles.append(theirInfo[6])
    }
}
