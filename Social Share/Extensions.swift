//
//  Extensions.swift
//  Social Share
//
//  Created by Samuel Jimenez and Andrew Jones on 11/2/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UIGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
