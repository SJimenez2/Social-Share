//
//  Handle.swift
//  Social Share
//
//  Created by Andrew Jones and Sam Jimenez on 12/6/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

class Handle: NSObject, NSCoding {
    
    struct Keys {
        static let Handle = "handle"
        static let Image = "image"
    }
    
    private var handle = ""
    private var image: UIImage?
    
    init(handle1: String, platform1: String) {
        self.handle = handle1
        if(platform1 == "Facebook") {
            self.image = #imageLiteral(resourceName: "Facebook Icon")
        } else if (platform1 == "Twitter") {
            self.image = #imageLiteral(resourceName: "Twitter Icon")
        } else if (platform1 == "Instagram") {
            self.image = #imageLiteral(resourceName: "Instagram Icon")
        }
    }

    //save data
    func encode(with aCoder: NSCoder) {
        aCoder.encode(handle, forKey: Keys.Handle)
        aCoder.encode(image, forKey: Keys.Image)
    }
    
    //load data
    required init?(coder aDecoder: NSCoder) {
        if let handleObj = aDecoder.decodeObject(forKey: Keys.Handle) as? String {
            handle = handleObj
        }
        if let imageObj = aDecoder.decodeObject(forKey: Keys.Image) as? UIImage {
            image = imageObj
        }
    }
    
    func getString() -> String{
        if self.image == #imageLiteral(resourceName: "Facebook Icon") {
            return "Facebook"
        } else if self.image == #imageLiteral(resourceName: "Twitter Icon") {
            return "Twitter"
        } else if self.image == #imageLiteral(resourceName: "Instagram Icon") {
            return "Instagram"
        }
        return "Image is Empty"
    }
    
    func getHandle() -> String{
        return handle
    }
    
    var Handle: String {
        get {
            return handle
        }
        set {
            handle = newValue
        }
    }
    
    var Image: UIImage {
        get {
            return image!
        }
        set {
            image = newValue
        }
    }
}
