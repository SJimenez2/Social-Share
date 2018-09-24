//
//  ViewController.swift
//  Social Share
//
//  Created by Sam Jimenez and Andrew Jones on 11/1/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit
//import CoreMotion

class MainScreen: UIViewController {
    
    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var QRCodeImage: UIImageView!
    
    let defaults = UserDefaults.standard
//    let motion = CMMotionManager()
    var userInfo = UserInfo()
    var generalInfo = GeneralInfo()
    var info: UserInfo?
    var qrString = ""
    var handle: [Handle] = []
//    var faceUp = false
//    var faceDown = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        }
        
        if segue.identifier == "editInfo" {
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
    
    func future() {
    // Kept in case of Bluetooth
    
//    @IBAction func startSharingActions(_ sender: UIButton) {
//        sharingButton.isHidden = true
//        sharingButton.isEnabled = false
//        if motion.isDeviceMotionAvailable {
//            motion.accelerometerUpdateInterval = 1
//            self.mainLabel.text = "Hold Phone Face Up"
//
//            motion.startAccelerometerUpdates(to: OperationQueue.current!) {(data, error) in
//                if let myData = data {
//
//                    self.checkFaceUp(data: myData)
//                    self.checkFaceDown(data: myData)
//                    
//                }
//            }
//        }
//    }
    
//    func checkFaceDown(data: CMAccelerometerData){
//        if !faceDown {
//            if data.acceleration.z > 0 {
//                let vc = self.storyboard?.instantiateViewController(withIdentifier: "AddAccounts") as! AddAccounts
//                self.present(vc, animated: true, completion: nil)
//            }
//        }
//    }
//
//    func checkFaceUp(data: CMAccelerometerData){
//        if !faceUp {
//            if data.acceleration.z < 0 {
//                self.mainLabel.text = "Flip Phone Down & Hold"
//                faceUp = true
//            }
//        }
//    }
    
//    func updateLabel(){
//        setLabel.text = socialBusiness.titleForSegment(at: socialBusiness.selectedSegmentIndex)
//    }
    }
}

