//
//  RegisterViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/5/7.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    @IBOutlet var tfNum: UITextField!
    @IBOutlet var tfName: UITextField!
    @IBOutlet var tfPassword: UITextField!
    @IBOutlet var tfPasswordAgain: UITextField!
    @IBOutlet var scrView: UIScrollView! // 为了键盘弹起来的时候 页面上滑
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 添加点击手势
        let gesture = UITapGestureRecognizer.init(target: self, action: #selector(hideKeyboard))
        self.view.addGestureRecognizer(gesture)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        
        // 设置监听 当键盘将要隐藏的时候 发通知给（调用）self.willHideKeyboard() 函数
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willHideKeyboard), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // 删除监听
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }

    @IBAction func clickToRegister(sender: UIButton) {
        self.hideKeyboard()
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
    
    // MARK: - 控制键盘
    
    func hideKeyboard() {
        if tfNum.isFirstResponder() || tfName.isFirstResponder() || tfPassword.isFirstResponder() || tfPasswordAgain.isFirstResponder() {
            tfNum.resignFirstResponder()
            tfName.resignFirstResponder()
            tfPassword.resignFirstResponder()
            tfPasswordAgain.resignFirstResponder()
        }
    }
    
    // 开始编辑的时候 设置滚动view的大小为两倍屏幕高 然后向上滚动一段距离
    func textFieldDidBeginEditing(textField: UITextField) {
        scrView.contentSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.height * 2)
        scrView.setContentOffset(CGPointMake(0, textField.frame.origin.y - 100), animated: true)
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
