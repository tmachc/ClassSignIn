//
//  AttendanceTableViewCell.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/1/10.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class AttendanceTableViewCell: UITableViewCell {
    
    /** 老师的备注 考勤名 */
    @IBOutlet var labAttendanceName: UILabel!
    /** 考勤时间 */
    @IBOutlet var labAttendanceDate: UILabel!
    /** 考勤状态 */
    @IBOutlet var labAttendanceState: UILabel!
    /** 老师结束签到 */
    @IBOutlet var btnEndAttendance: UIButton!
    
    /** 考勤数据 */
    var dicAttendanceData = Dictionary<String, AnyObject>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        btnEndAttendance.alpha = 0
        var state = ""
        if userDefault.objectForKey("type")!.isEqual("teacher") {
            self.labAttendanceState.alpha = 0
            if self.dicAttendanceData["attendanceState"]!.isEqual("start") {
                btnEndAttendance.alpha = 1
                btnEndAttendance.setTitle("结束签到", forState: .Normal)
                btnEndAttendance.backgroundColor = RGBColor(r: 185, g: 227, b: 133)
            }
        }
        else {
            self.labAttendanceState.alpha = 1
            let arr = dicAttendanceData["classMate"] as! Array<Dictionary<String, AnyObject>>
            state = arr[0]["attendanceState"] as! String
            if self.dicAttendanceData["attendanceState"]!.isEqual("start") && state == "1" {
                self.labAttendanceState.alpha = 0
                btnEndAttendance.alpha = 1
                btnEndAttendance.setTitle("签到", forState: .Normal)
                btnEndAttendance.backgroundColor = UIColor.greenColor()
            }
        }
        
        self.labAttendanceName.text = self.dicAttendanceData["attendanceName"] as? String
        
        self.labAttendanceDate.text = self.dicAttendanceData["attendanceDate"] as? String
        
        switch state {
            case "1":
                self.labAttendanceState.text = "旷课"
            case "2":
                self.labAttendanceState.text = "迟到"
            case "3":
                self.labAttendanceState.text = "请假"
            case "4":
                self.labAttendanceState.text = "出勤"
            default:
                self.labAttendanceState.text = "旷课"
        }
        if selected {
            self.selected = false  // 点击cell 选中效果立即消失
        }
        // Configure the view for the selected state
    }

    @IBAction func endAttendance(sender: UIButton) {
        var dic = [
            "command": "endSignIn",
            "attendanceId": self.dicAttendanceData["attendanceId"]!
        ]
        if userDefault.objectForKey("type")!.isEqual("student") {
            dic["command"] = "stuSignIn"
            dic["studentId"] = userDefault.objectForKey("_id")
            dic["state"] = "4"
        }
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: dic ) { (result) in
            if result["code"]!.isEqual(0) {
                NSNotificationCenter.defaultCenter().postNotificationName("reloadList", object: nil)
            }
        }
    }
}


