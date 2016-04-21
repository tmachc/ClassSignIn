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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                    vc.strClassId = self.dicClassData["classId"]! as String
                    vc.getNoticeListData()
                }
            }
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func addClass(sender: UIButton) {
        if tabbarIndex == 0 {
            // 创建作业
            
            let vc = self.childViewControllers.first as! HomeworkViewController
            vc.performSegueWithIdentifier("editHomework", sender: nil)
        }
        else if tabbarIndex == 1 {
            // 创建通知
            HttpManager.defaultManager.getRequest(
                url: HttpUrl,
                params: ["command": "editNotice", "noticeName": "开课", "noticeContent": "准备开课啦", "noticeDate": "9月10日", "classId": dicClassData["classId"]!],
                complete:
                { (result) -> Void in
                    if result["code"]!.isEqual(0) {
                        
                    }
            })
        }
        else {
            // 添加考勤记录
        }
    }

}
