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
        
        self.navigationController?.navigationBarHidden = true
        
        tfUserName.text = "2010011182"
        tfPassword.text = "123"
        
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func clickLogin(sender: UIButton) {
        // 先判断输入的是否为空
        if tfUserName.text == "" {
            return;
        }
        if tfPassword.text == "" {
            return;
        }
        
        // ******* 网络请求
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: ["command": "login", "num": tfUserName.text!, "password": tfPassword.text!])
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
    }

}
