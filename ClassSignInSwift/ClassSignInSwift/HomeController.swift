//
//  HomeController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/11/26.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit
import Alamofire

class HomeController: UITabBarController {
    
    var isFromEditMy = false

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 定义所有子页面返回按钮的名称
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        if isFromEditMy {
            self.selectedIndex = 1
            isFromEditMy = false
            let myViewController = self.viewControllers?.last as! MyViewController
            myViewController.viewWillAppear(false)
        }
        else {
            self.selectedIndex = 0
        }
        
        let classViewController : ClassViewController = self.childViewControllers.first as! ClassViewController
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: classViewController, action: #selector(classViewController.addClass))
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    override func viewDidAppear(animated: Bool) {
        // 判断是否登录了
        // 没登陆跳登录页 
        // 登陆了判断 type 获取课程列表
        
        if (userDefault.objectForKey("num") != nil) {
            // 登录了
            let classViewController : ClassViewController = self.viewControllers?.first as! ClassViewController
            classViewController.getClassData()
        }
        else {
            // 没登录，去登录
            self.performSegueWithIdentifier("login", sender: nil)
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        self.title = item.title
        if item.tag == 0 {
            // 课堂
            let classViewController : ClassViewController = self.viewControllers?.first as! ClassViewController
            let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: classViewController, action: #selector(classViewController.addClass))
            self.navigationItem.rightBarButtonItem = itemRight
        }
        else {
            self.navigationItem.rightBarButtonItem = nil
        }
    }
    
}



