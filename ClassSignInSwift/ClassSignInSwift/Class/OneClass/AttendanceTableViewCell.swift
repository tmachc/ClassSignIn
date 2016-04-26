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
    
    /** 考勤数据 */
    var dicAttendanceData = Dictionary<String, String>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if userDefault.objectForKey("type")!.isEqual("teacher") {
            self.labAttendanceState.alpha = 0
        }
        else {
            self.labAttendanceState.alpha = 1
        }
        
        self.labAttendanceName.text = self.dicAttendanceData["attendanceName"]
        self.labAttendanceDate.text = self.dicAttendanceData["attendanceDate"]
        if self.dicAttendanceData["attendanceState"] == "1" {
            self.labAttendanceState.text = "旷课"
        }
        else if self.dicAttendanceData["attendanceState"] == "2" {
            self.labAttendanceState.text = "迟到"
        }
        else if self.dicAttendanceData["attendanceState"] == "3" {
            self.labAttendanceState.text = "请假"
        }
        else if self.dicAttendanceData["attendanceState"] == "4" {
            self.labAttendanceState.text = "出勤"
        }
        if selected {
            self.selected = false  // 点击cell 选中效果立即消失
        }
        // Configure the view for the selected state
    }

}
