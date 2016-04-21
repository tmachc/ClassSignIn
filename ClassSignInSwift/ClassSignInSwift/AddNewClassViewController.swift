//
//  AddNewClassViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/4/18.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class AddNewClassViewController: UIViewController {

    @IBOutlet var tfClassNum: UITextField!
    
    @IBOutlet var labIntro: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if userDefault.objectForKey("type")!.isEqual("teacher") {
            // 创建课程
            self.title = "创建课程"
            self.tfClassNum.placeholder = "输入课程名称"
            self.labIntro.text = "通过课程名称来创建班级"
        }
        else {
            // 加入课程
            self.title = "加入班级"
            self.tfClassNum.placeholder = "输入课程号"
            self.labIntro.text = "通过6位课程号加入班级"
        }
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAdd))
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    func clickToAdd() {
        if tfClassNum.text == "" {
            return;
        }
        if userDefault.objectForKey("type")!.isEqual("teacher") {
            HttpManager.defaultManager.getRequest(
                url: HttpUrl,
                params: [
                    "command": "editClass",
                    "className": tfClassNum.text!,
                    "teacherId": userDefault.objectForKey("_id")!,
                    "teacherName": userDefault.objectForKey("name")!],
                complete:
                { (result) -> Void in
                    if result["code"]!.isEqual(0) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
            })
        }
        else {
            HttpManager.defaultManager.getRequest(
                url: HttpUrl,
                params: [
                    "command": "addToClass",
                    "classNum": tfClassNum.text!,
                    "studentId": userDefault.objectForKey("_id")!,
                    "studentNum": userDefault.objectForKey("num")!,
                    "studentSex": userDefault.objectForKey("sex")!,
                    "studentName": userDefault.objectForKey("name")!],
                complete:
                { (result) -> Void in
                    if result["code"]!.isEqual(0) {
                        self.navigationController?.popViewControllerAnimated(true)
                    }
            })
        }
    }
}
