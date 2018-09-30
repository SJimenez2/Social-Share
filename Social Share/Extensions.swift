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

extension UIView {
    func setGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = bounds
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)

        layer.insertSublayer(gradientLayer, at: 0)
    }
}
