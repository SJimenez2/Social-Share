//
//  ViewController.swift
//  QRReader
//
//  Created by Primary scanning code: Sebastian Hette with additions from
//  Sam Jimenez and Andrew Jones on 17.07.2017.
//  Copyright © 2017 MAGNUMIUM. All rights reserved.
//

import UIKit
import AVFoundation

class QRViewController: UIViewController {
    
    @IBOutlet weak var topBar: UIView!
    var video = AVCaptureVideoPreviewLayer()
    var theirInfo: String = ""
    var qrCodeFrameView: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //Creating session
        let session = AVCaptureSession()
        
        //Define capture devcie
        let deviceDescovery = AVCaptureDevice.DiscoverySession(deviceTypes: [.builtInDualCamera], mediaType: AVMediaType.video, position: .back)
        let captureDevice = deviceDescovery.devices.first
        
        do
        {
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
            
            let output = AVCaptureMetadataOutput()
            session.addOutput(output)
            
            output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
            
            output.metadataObjectTypes = [AVMetadataObject.ObjectType.qr]
        }
        catch
        {
            print ("ERROR")
        }
        
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.videoGravity = AVLayerVideoGravity.resizeAspectFill
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        
        session.startRunning()
        
        view.bringSubview(toFront: topBar)
        
        qrCodeFrameView = UIView()
        
        if let qrCodeFrameView = qrCodeFrameView {
            qrCodeFrameView.layer.borderColor = UIColor.green.cgColor
            qrCodeFrameView.layer.borderWidth = 2
            view.addSubview(qrCodeFrameView)
            view.bringSubview(toFront: qrCodeFrameView)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddAcounts" {
            let vc = segue.destination as! AddAccounts
            vc.saveRecievedInfo(info: theirInfo)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension QRViewController: AVCaptureMetadataOutputObjectsDelegate {
    
    func metadataOutput(_ captureOutput: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        
        if metadataObjects.count != 0
        {
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject
            {
                if object.type == AVMetadataObject.ObjectType.qr
                {
                    theirInfo = object.stringValue!
                    
                    performSegue(withIdentifier: "toAddAcounts", sender: self)
                }
            }
        }
    }
}
