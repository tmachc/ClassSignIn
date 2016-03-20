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

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dicClassData["className"]

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        if item.tag == 0 {
            // 作业
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

}
