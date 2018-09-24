//
//  SaveHandle.swift
//  Social Share
//
//  Created by Andrew Jones and Sam Jimenez on 11/3/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

class SaveHandle: UIViewController {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var handle: UITextField!
    
    var name: String = ""
    var enteredHandle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        handle.becomeFirstResponder()
        label.text = "Save \(name) Handle"
        handle.text = enteredHandle
    }
    
    @IBAction func saveHandle(_ sender: UIButton) {
       performSegue(withIdentifier: "unwind", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "HelpScreen" {
            let vc = segue.destination as! FindingHandle
            vc.platform = name
        }
    }
    
    @IBAction func unwind(segue: UIStoryboardSegue) {
    }
}
