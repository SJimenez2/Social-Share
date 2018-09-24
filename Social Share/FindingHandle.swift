//
//  FindingHandle.swift
//  Social Share
//
//  Created by Andrew Jones and Sam Jimenez on 12/7/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

class FindingHandle: UIViewController {
    var platform: String = ""
    var image: UIImage? = nil
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        if platform == "Facebook" {
            image = #imageLiteral(resourceName: "Facebook")
            imageView.image = image
        } else if platform == "Twitter" {
            image = #imageLiteral(resourceName: "Twitter")
            imageView.image = image
        } else if platform == "Instagram" {
            image = #imageLiteral(resourceName: "Instagram")
            imageView.image = image
        }
    }
    
    @IBAction func backToSaveHandle(_ sender: UIButton) {
         performSegue(withIdentifier: "unwindToSaveHandle", sender: self)
    }
    
}
