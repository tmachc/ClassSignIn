//
//  RegisterViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/5/7.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet var tfNum: UITextField!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfPasswordAgain: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
    }

    @IBAction func clickToRegister(sender: UIButton) {
        // 先判断输入的是否为空
        if tfNum.text == "" {
            
            return
        }
        if tfName.text == "" {
            
            return
        }
        if tfPassword.text == "" {
            return
        }
        if tfPasswordAgain.text == "" {
            return
        }
        if tfPassword.text != tfPasswordAgain.text {
            return
        }
        // ******* 网络请求
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "register",
                "num": tfNum.text!,
                "name": tfName.text!,
                "password": tfPassword.text!
            ])
        { (result) -> Void in
            
            if result["code"]!.isEqual(0) {
                for (key, value) in result["user"] as! [String: AnyObject] {
                    userDefault.setObject(value, forKey: key)
                }
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else {
                let alert = UIAlertController.init(title: "提示", message: result["message"] as? String, preferredStyle: UIAlertControllerStyle.Alert)
                let cancel = UIAlertAction.init(title: "确定", style: .Cancel, handler: nil)
                alert.addAction(cancel)
                self.presentViewController(alert, animated: true, completion: nil)
            }
        }
    }
}
