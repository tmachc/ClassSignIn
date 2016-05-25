//
//  EditMyViewController.swift
//  ClassSignInSwift
//
//  Created by ccwonline on 16/5/10.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class EditMyViewController: UIViewController {
    
    @IBOutlet var label: UILabel!
    @IBOutlet var textField: UITextField!
    
    var row = 0
    var key = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(editMy))
        self.navigationItem.rightBarButtonItem = itemRight
        
        print(self.navigationItem.backBarButtonItem)
        print(self.navigationItem.leftBarButtonItem)
        
        switch row {
        case 0:
            self.title = "编辑姓名"
            label.text = "姓名："
            textField.text = userDefault.objectForKey("name") as? String
            key = "name"
        case 1:
            self.title = "编辑学号"
            label.text = "学号："
            textField.text = userDefault.objectForKey("num") as? String
            key = "num"
        case 2:
            self.title = "编辑性别"
            label.text = "性别："
            textField.text = userDefault.objectForKey("sex") as? String
            key = "sex"
        case 3:
            self.title = "编辑年龄"
            label.text = "年龄："
            textField.text = userDefault.objectForKey("age") as? String
            textField.keyboardType = .PhonePad
            key = "age"
        default:
            self.title = "编辑姓名"
            label.text = "姓名："
            textField.text = userDefault.objectForKey("name") as? String
            key = "name"
        }
        
        textField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        let homeControl = self.navigationController!.viewControllers.first as! HomeController
        homeControl.isFromEditMy = true
    }
    
    func editMy() {
        if textField.text == "" {
            return
        }
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "editMy",
                key: textField.text!,
                "userId": userDefault.objectForKey("_id")!
            ])
        { (result) -> Void in
            
            if result["code"]!.isEqual(0) {
                for (key, value) in result["user"] as! [String: AnyObject] {
                    userDefault.setObject(value, forKey: key)
                }
//                let homeControl = self.navigationController!.viewControllers.first as! HomeController
//                homeControl.isFromEditMy = true
                self.navigationController?.popViewControllerAnimated(true)
                self.navigationController?.navigationBarHidden = false
            }
            else {
                ShowAlert(target: self, message: result["message"] as! String)
            }
        }
    }
}
