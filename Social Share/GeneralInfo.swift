//
//  GeneralInfo.swift
//  Social Share
//
//  Created by Andrew Jones and Sam Jimenez on 11/1/17.
//  Copyright © 2017 SS, Inc. All rights reserved.
//

import UIKit

public class GeneralInfo: UIViewController , UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var phoneNum: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var table: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    let saveHandle = SaveHandle()
    var userInfo = UserInfo()
    var editingUser = false
    
    var handles: [Handle] = []
    
    //create a path to store data
    var filePath: String {
        //manages files and folders in app to store directory for save data
        let manager = FileManager.default
        //returns the first of an array of urls //recommened location for saving information in app
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first
        //create a new path component and create this file in that path component
        return url!.appendingPathComponent("Data").path
    }
    
    override public func viewDidLoad() {
        hideKeyboardWhenTappedAround()
        
        saveButton.isEnabled = false
        firstName.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        lastName.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        phoneNum.addTarget(self, action: #selector(editingChanged(_:)), for: .editingChanged)
        
        UserDefaults.standard.set(filePath, forKey: "File Path")
        
        if editingUser {
            editingUser = false
            editInfo()
        }
    }
    
    private func loadTableData() {
        if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: UserDefaults.standard.object(forKey: "File Path") as! String) as? [Handle] {
            handles = ourData
        }
    }
    
    // UserDefaults.standard.object(forKey: "File Path") returns nil
    private func saveData(handle: Handle) {
        handles.append(handle)
        NSKeyedArchiver.archiveRootObject(handles, toFile: UserDefaults.standard.object(forKey: "File Path") as! String)
    }
    
    func createQRString(user: UserInfo) -> String {
    
            var qrString = "\(user.fname),\(user.lname),\(user.phone),\(user.email)"
        
            //go through the handles array
            for i in 0..<user.handles.count {
                //if the handle is not blank
                if user.handles[i] != "" {
                    qrString = qrString + "," + user.handles[i]
                } else {
                    qrString = qrString + ","
                }
            }
        qrString = qrString + "."
        UserDefaults.standard.set(qrString, forKey: "SharedInfo")
        return qrString
    }
    
    //if we are segueing to MainScreen
    override public func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMain" {
            
            UserDefaults.standard.set(true, forKey: "Opened Before")
            UserDefaults.standard.set(filePath, forKey: "File Path")
            userInfo = UserInfo.init(fname1: firstName.text!, lname1: lastName.text!, phone1: phoneNum.text!, email1: email.text!, handlesArray: handles)
            NSKeyedArchiver.archiveRootObject(userInfo, toFile: filePath)
            if let ourData = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? UserInfo {
                userInfo = ourData
            }
        }
    }
    
    //unwinding from saving the handle in SaveHandle
    @IBAction func unwind(segue: UIStoryboardSegue) {
        //if segueing from SaveHandle class
        if segue.source is SaveHandle {
            //create and instance of the SaveHandle class
            if let handleVC = segue.source as? SaveHandle {
                //set a handle and a name variable
                let handleString = handleVC.handle.text
                let name = handleVC.name
                //create a handle object and assign it values and add it to handles array.
                let handle = Handle(handle1: handleString!, platform1: name)
                
                //save our data
                self.saveData(handle: handle)
                //reload table
                table.reloadData()
            }
        }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return handles.count
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //create a cell and cast it as a InfoTableViewCell
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)  as! InfoTableViewCell
        //take the handle at indexPath.row and set handle and image variables equal to the cell's label and image
        let handle = handles[indexPath.row]
        
        if handle.Image ==  UIImage(named: "Instagram Icon") {
            cell.setGradientBackground(colorOne: Colors.magenta, colorTwo: Colors.lightOrange)
            cell.tableViewImage.image = UIImage(named: "InstagramTransparent")
        } else if handle.Image == UIImage(named: "Facebook Icon") {
            cell.setGradientBackground(colorOne: Colors.blue, colorTwo: Colors.white)
            cell.tableViewImage.image = UIImage(named: "FacebookTransparent")
        } else if handle.Image == UIImage(named: "Twitter Icon") {
            cell.setGradientBackground(colorOne: Colors.skyBlue, colorTwo: Colors.white)
            cell.tableViewImage.image = UIImage(named: "TwitterTransparent")
        }
        
        cell.tableViewLabel.text = handle.Handle
        //return the completed cell
        return cell
    }
    
    //disabling save button so long as fname, lname, and phone are not filled out
    @objc func editingChanged(_ textField: UITextField) {
        //check to see if the text field is only a space, then return it back to nothing
        
        if textField.text?.count == 1 {
            if textField.text?.first == " " {
                textField.text = ""
                return
            }
        }
        guard
            let fName = firstName.text, !fName.isEmpty,
            let lName = lastName.text, !lName.isEmpty,
            let phone = phoneNum.text, !phone.isEmpty
            else {
                saveButton.isEnabled = false
                return
        }
        saveButton.isEnabled = true
        saveButton.tintColor = UIColor.black
    }
    
    public func tableView(_ tableView: UITableView, editActionsForRowAt: IndexPath) -> [UITableViewRowAction]? {
        let edit = UITableViewRowAction(style: .normal, title: "Edit") { action, index in
            
            if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SaveHandle") as? SaveHandle
            {
                let editedInfo = self.handles.remove(at: editActionsForRowAt.row)
                
                vc.enteredHandle = editedInfo.getHandle()
                vc.name = editedInfo.getString()
                self.present(vc, animated: true, completion: nil)
            }
        }
        edit.backgroundColor = .orange
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            
            self.handles.remove(at: editActionsForRowAt.row)
            
            tableView.deleteRows(at: [editActionsForRowAt], with: .automatic)
        }
        delete.backgroundColor = .red
        
        return [delete, edit]
    }
    
    func editInfo(){
        
        loadTableData()
        firstName.insertText(userInfo.fname)
        lastName.insertText(userInfo.lname)
        email.insertText(userInfo.email)
        phoneNum.insertText(userInfo.phone)
    }
}
