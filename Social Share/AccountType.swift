//
//  AccountType.swift
//  Social Share
//
//  Created by Andrew Jones and Sam Jimenez on 11/1/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

class AccountType: UIViewController {
    
    @IBOutlet weak var Facebook: UIImageView!
    @IBOutlet weak var Twitter: UIImageView!
    @IBOutlet weak var Instagram: UIImageView!
    
    
    
    let saveHandle = SaveHandle()
    let socialSave = GeneralInfo()
    
    var images: [UIImageView] = []
    var which: Int = -1
    
    override func viewDidLoad() {
        images = [Facebook, Twitter, Instagram]
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! SaveHandle
        vc.name = segue.identifier!
    }
}
