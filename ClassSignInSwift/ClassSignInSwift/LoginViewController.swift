//
//  LoginViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/11/27.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire

class LoginViewController: UIViewController {

    @IBOutlet var tfUserName: UITextField!
    @IBOutlet var tfPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserName.text = "2010011182"
        tfPassword.text = "123"
        
        // 定义所有子页面返回按钮的名称
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
    }
    
    @IBAction func clickLogin(sender: UIButton) {
        // 先判断输入的是否为空
        if tfUserName.text == "" {
            
            return
        }
        if tfPassword.text == "" {
            return
        }
        
        // ******* 网络请求
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "login",
                "num": tfUserName.text!,
                "password": tfPassword.text!
            ])
            { (result) -> Void in
                
                if result["code"]!.isEqual(0) {
                    for (key, value) in result["user"] as! [String: AnyObject] {
                        userDefault.setObject(value, forKey: key)
                    }
                    self.navigationController?.popViewControllerAnimated(true)
                    self.navigationController?.navigationBarHidden = false
                }
                else {
                    
                }
        }
    }
    
    @IBAction func clickToRegisterPage(sender: UIButton) {
        self.performSegueWithIdentifier("register", sender: nil)
    }
}
