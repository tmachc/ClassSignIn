//
//  EditNoticeViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/4/23.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class EditNoticeViewController: UIViewController {
    
    var classId = ""
    var noticeId = ""
    @IBOutlet var tfNoticeName: UITextField!
    @IBOutlet var tvNoticeContent: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAdd))
        self.navigationItem.rightBarButtonItem = itemRight
        
        if noticeId == "" {
            self.tvNoticeContent.text = ""
            self.title = "添加通知"
        }
        else {
            self.title = "编辑通知"
        }
    }
    
    func clickToAdd() {
        if tfNoticeName.text == "" {
            return;
        }
        if tvNoticeContent.text == "" {
            return;
        }
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "editNotice",
                "noticeName": self.tfNoticeName.text!,
                "noticeContent": self.tvNoticeContent.text!,
                "classId": classId],
            complete:
            { (result) -> Void in
                if result["code"]!.isEqual(0) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
        })
        
    }
}
