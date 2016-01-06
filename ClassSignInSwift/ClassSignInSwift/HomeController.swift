//
//  HomeController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/11/26.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit

class HomeController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        print("hello world")
        
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addClass:")
        self.navigationItem.rightBarButtonItem = itemRight
        // 定义所有子页面返回按钮的名称
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "返回", style: UIBarButtonItemStyle.Done, target: nil, action: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        // 判断是否登录了 没登陆跳登录页
//        self.performSegueWithIdentifier("login", sender: nil)
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        self.title = item.title
        print(item)
        if item.tag == 0 {
            // 课堂
            let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: "addClass:")
            self.navigationItem.rightBarButtonItem = itemRight
        }
        else {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }

    @IBAction func addClass(sender: UIButton) {
        
    }
    
}
