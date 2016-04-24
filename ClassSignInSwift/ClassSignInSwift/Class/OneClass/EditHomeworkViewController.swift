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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemRight = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.clickToAdd))
        self.navigationItem.rightBarButtonItem = itemRight
        
        if homeworkId == "" {
            self.tvHomeworkContent.text = ""
            self.title = "添加作业"
        }
        else {
            self.title = "编辑作业"
        }
        datePicker.alpha = 0
        btnDate.alpha = 0
        datePicker.setDate(NSDate.init(timeIntervalSinceNow: 3600), animated: false)
    }
    
    func clickToAdd() {
        if tfHomeworkName.text == "" {
            return;
        }
        if tfHomeworkDate.text == "" {
            return;
        }
        if tvHomeworkContent.text == "" {
            return;
        }
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "editHomework",
                "homeworkName": self.tfHomeworkName.text!,
                "homeworkDate": self.tfHomeworkDate.text!,
                "homeworkContent": self.tvHomeworkContent.text!,
                "classId": classId],
            complete:
            { (result) -> Void in
                if result["code"]!.isEqual(0) {
                    self.navigationController?.popViewControllerAnimated(true)
                }
        })

    }
    
    @IBAction func addDateToLabel(sender: UIButton?) {
        let dateFormat = NSDateFormatter.init()
        dateFormat.dateFormat = "yy年M月d日 HH:mm"
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
            btnDate.alpha = 0;
        }
        return true
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        self.datePicker.alpha = 0
        btnDate.alpha = 0;
        return true
    }
}
