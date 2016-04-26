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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // 定义所有子页面返回按钮的名称
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.selectedIndex = 0
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.addClass))
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    override func viewDidAppear(animated: Bool) {
        // 判断是否登录了
        // 没登陆跳登录页 
        // 登陆了判断 type 获取课程列表
        
        if (userDefault.objectForKey("num") != nil) {
            // 登录了
            let classViewController : ClassViewController = self.viewControllers?.first as! ClassViewController
            if userDefault.objectForKey("type")!.isEqual("teacher") {
                // 老师端
            }
            else {
                // 学生端
            }
            classViewController.getClassData()
        }
        else {
            // 没登录，去登录
            self.performSegueWithIdentifier("login", sender: nil)
        }
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        self.title = item.title
        print(item)
        if item.tag == 0 {
            // 课堂
            let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(self.addClass))
            self.navigationItem.rightBarButtonItem = itemRight
        }
        else {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }

    func addClass(sender: UIButton) {
        self.performSegueWithIdentifier("addNewClass", sender: nil)
    }
    
}



