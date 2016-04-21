//
//  EditHomeworkViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/4/21.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class EditHomeworkViewController: UIViewController {

    var classId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAdd))
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    func clickToAdd() {
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: ["command": "editHomework", "homeworkName": "家庭作业", "homeworkContent": "课文抄10遍", "homeworkDate": "4月10日", "classId": classId],
            complete:
            { (result) -> Void in
                if result["code"]!.isEqual(0) {
                    
                }
        })

    }

}
