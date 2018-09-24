//
//  inAppWeb.swift
//  Social Share
//
//  Created by Sam Jimenez and Andrew Jones on 11/6/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit
import WebKit

class inAppWeb: UIViewController, WKUIDelegate {
    
    @IBOutlet weak var web: WKWebView!
    
    var website = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string: website)
        let myRequest = URLRequest(url: myURL!)
        web.load(myRequest)
    }
    
    @IBAction func doneButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }

}
