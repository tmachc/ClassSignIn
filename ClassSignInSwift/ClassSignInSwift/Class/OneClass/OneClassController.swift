//
//  OneClassController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/1/4.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class OneClassController: UITabBarController {
    
    var dicClassData = Dictionary<String, String>()
    var tabbarIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dicClassData["className"]
        if userDefault.objectForKey("type")!.isEqual("teacher") {
            let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Add, target: self, action: #selector(OneClassController.addClass(_:)))
            self.navigationItem.rightBarButtonItem = itemRight
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tabBar(self.tabBar, didSelectItem: self.tabBar.items![tabbarIndex])
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        tabbarIndex = item.tag
        if item.tag == 0 {
            // 作业
            let vc = self.childViewControllers.first as! HomeworkViewController
            vc.getHomeworkListData()
        }
        else if item.tag == 2 {
            // 考勤
        }
        else {
            // 通知
            for viewC in self.childViewControllers {
                if viewC.isKindOfClass(NoticeViewController) {
                    let vc = viewC as! NoticeViewController
                    vc.getNoticeListData()
                }
            }
        }
    }
    
    @IBAction func addClass(sender: UIButton) {
        if tabbarIndex == 0 {
            // 创建作业
            
            let vc = self.childViewControllers.first as! HomeworkViewController
            vc.performSegueWithIdentifier("editHomework", sender: nil)
        }
        else if tabbarIndex == 1 {
            // 创建通知
            
            let vc = self.childViewControllers[1] as! NoticeViewController
            vc.performSegueWithIdentifier("editNotice", sender: nil)
        }
        else {
            // 添加考勤记录
            
        }
    }

}
