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

class LoginViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet var tfUserName: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var scrView: UIScrollView! // 为了键盘弹起来的时候 页面上滑

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfUserName.text = "34201608"
        tfPassword.text = "123"
        
        // 定义所有子页面返回按钮的名称
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
        
        // 添加点击手势
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
        
        // 设置监听 当键盘将要隐藏的时候 发通知给（调用）self.willHideKeyboard() 函数
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willHideKeyboard), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        // 删除监听
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    @IBAction func clickLogin(sender: UIButton) {
        self.hideKeyboard()
        // 先判断输入的是否为空
        if tfUserName.text == "" {
            ShowAlert(target: self, message: "学号或教职工号不能为空")
            return
        }
        if tfPassword.text == "" {
            ShowAlert(target: self, message: "密码不能为空")
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
                    ShowAlert(target: self, message: result["message"] as! String)
                }
        }
    }
    
    @IBAction func clickToRegisterPage(sender: UIButton) {
        self.hideKeyboard()
        self.performSegueWithIdentifier("register", sender: nil)
    }
    
    // MARK: - 控制键盘
    
    func hideKeyboard() {
        if tfPassword.isFirstResponder() || tfUserName.isFirstResponder() {
            tfPassword.resignFirstResponder()
            tfUserName.resignFirstResponder()
        }
    }
    
    // 开始编辑的时候 设置滚动view的大小为两倍屏幕高 然后向上滚动一段距离
    func textFieldDidBeginEditing(textField: UITextField) {
        scrView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2)
        scrView.setContentOffset(CGPointMake(0, 100), animated: true)
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        self.hideKeyboard()
    }
    
    // 收起（隐藏）键盘的时候 设置滚动view为当前屏幕大小，回到 (0,0)
    func willHideKeyboard() {
        scrView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height)
        scrView.setContentOffset(CGPointZero, animated: true)
    }
}
