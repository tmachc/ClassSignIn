//
//  EditHomeworkViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/4/21.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class EditHomeworkViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    var classId = ""
    var homeworkId = ""
    @IBOutlet var tfHomeworkName: UITextField!
    @IBOutlet var tfHomeworkDate: UITextField!
    @IBOutlet var tvHomeworkContent: UITextView!
    @IBOutlet var datePicker: UIDatePicker!
    @IBOutlet var btnDate: UIButton!
    
    var dicHomeworkData = Dictionary<String, String>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAddHomework))
        self.navigationItem.rightBarButtonItem = itemRight
        
        if homeworkId == "" {
            self.title = "添加作业"
            self.tvHomeworkContent.text = ""
            // 设置datepicker的时间为当前时间加上 3600秒（一个小时）
            datePicker.setDate(NSDate.init(timeIntervalSinceNow: 3600), animated: false)
        }
        else {
            self.title = "编辑作业"
            self.tfHomeworkName.text = dicHomeworkData["homeworkName"]
            self.tfHomeworkDate.text = dicHomeworkData["homeworkDate"]
            self.tvHomeworkContent.text = dicHomeworkData["homeworkContent"]
            // 创建一个常量 是 日期格式转换类的实例
            let dateFormat = NSDateFormatter.init()
            // 设置日期格式
            dateFormat.dateFormat = "yy年M月d日 HH:mm"
            // 设置datepicker的时间为  （dicHomeworkData["homeworkDate"] 转换格式后的时间）
            datePicker.setDate(dateFormat.dateFromString(dicHomeworkData["homeworkDate"]!)!, animated: false)
            // dicHomeworkData["homeworkDate"] 是 yy年M月d日 HH:mm 这样的字符串 上面这个是 String -> NSDate 因为.setDate()函数里面要传NSDate类型的参数
        }
        
        datePicker.alpha = 0
        btnDate.alpha = 0
    }
    
    func clickToAddHomework() {
        if tfHomeworkName.text == "" {
            ShowAlert(target: self, message: "作业名称不能为空")
            return
        }
        if tfHomeworkDate.text == "" {
            ShowAlert(target: self, message: "作业时间不能为空")
            return
        }
        if tvHomeworkContent.text == "" {
            ShowAlert(target: self, message: "作业内容不能为空")
            return
        }
        var dic = [
            "command": "editHomework",
            "homeworkName": self.tfHomeworkName.text!,
            "homeworkDate": self.tfHomeworkDate.text!,
            "homeworkContent": self.tvHomeworkContent.text!,
            "classId": classId]
        if homeworkId != "" {
            dic["homeworkId"] = homeworkId
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
    
    @IBAction func addDateToLabel(sender: UIButton?) {
        // 创建一个常量 是 日期格式转换类的实例
        let dateFormat = NSDateFormatter.init()
        // 设置日期格式
        dateFormat.dateFormat = "yy年M月d日 HH:mm"
        // 设置输入框的文字为 （datePicker的日期 转换格式后的字符串）
        // datePicker的日期是 NSDate类型的 现在要转换成 String
        tfHomeworkDate.text = dateFormat.stringFromDate(datePicker.date)
    }

    func textFieldShouldBeginEditing(textField: UITextField) -> Bool {
        if textField.isEqual(tfHomeworkDate) {
            self.datePicker.alpha = 1
            btnDate.alpha = 1
            self.tfHomeworkName.resignFirstResponder()
            self.tvHomeworkContent.resignFirstResponder()
            return false
        }
        else {
            self.datePicker.alpha = 0
            btnDate.alpha = 0
        }
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.datePicker.alpha = 0
        btnDate.alpha = 0
        return true
    }
}
