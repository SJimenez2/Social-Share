//
//  IntroScreen.swift
//  Social Share
//
//  Created by Sam Jimenez and Andrew Jones on 11/7/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

class IntroScreen: UIViewController {
    
    @IBOutlet weak var saveType: UISegmentedControl!
    
    
    override func viewDidLoad() {
        saveType.isHidden = true
    }
    
    @IBAction func changeVC(_ sender: UIButton) {
        if(saveType.selectedSegmentIndex == 0) {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "GeneralInfo") as! GeneralInfo
                self.present(vc, animated: true, completion: nil)
        }
    }
}
