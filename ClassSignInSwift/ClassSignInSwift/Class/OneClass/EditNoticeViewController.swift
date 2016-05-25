//
//  EditNoticeViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/4/23.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class EditNoticeViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    var classId = ""
    var noticeId = ""
    @IBOutlet var tfNoticeName: UITextField!
    @IBOutlet var tvNoticeContent: UITextView!
    
    var dicNoticeData = Dictionary<String, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAdd))
        self.navigationItem.rightBarButtonItem = itemRight
        
        if noticeId == "" {
            self.title = "添加通知"
            self.tvNoticeContent.text = ""
        }
        else {
            self.title = "编辑通知"
            self.tfNoticeName.text = dicNoticeData["noticeName"]
            self.tvNoticeContent.text = dicNoticeData["noticeContent"]
        }
    }
    
    func clickToAdd() {
        if tfNoticeName.text == "" {
            ShowAlert(target: self, message: "通知名称不能为空")
            return
        }
        if tvNoticeContent.text == "" {
            ShowAlert(target: self, message: "通知内容不能为空")
            return
        }
        var dic = [
            "command": "editNotice",
            "noticeName": self.tfNoticeName.text!,
            "noticeContent": self.tvNoticeContent.text!,
            "classId": classId]
        if noticeId != "" {
            dic["noticeId"] = noticeId
        }
        
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: dic,
            complete:
            { (result) -> Void in
                if result["code"]!.isEqual(0) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
                else {
                    ShowAlert(target: self, message: result["message"] as! String)
                }
        })
        
    }
    
}
