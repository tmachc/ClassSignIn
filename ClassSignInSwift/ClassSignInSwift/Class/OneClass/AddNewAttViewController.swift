//
//  AddNewAttViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/5/4.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class AddNewAttViewController: UIViewController {
    
    @IBOutlet var tfAttendanceName: UITextField!
    
    @IBOutlet var labIntro: UILabel!
    
    var classId = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "创建考勤"
        self.tfAttendanceName.placeholder = "输入考勤名称"
        self.labIntro.text = "添加一个名称来创建考勤"
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAdd))
        self.navigationItem.rightBarButtonItem = itemRight
    }
    
    func clickToAdd() {
        if tfAttendanceName.text == "" {
            ShowAlert(target: self, message: "考勤名称不能为空")
            return
        }
        
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "editAttendance",
                "attendanceName": tfAttendanceName.text!,
                "classId": self.classId],
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
