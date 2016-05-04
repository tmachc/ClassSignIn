//
//  AttStuListTableViewCell.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/5/4.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class AttStuListTableViewCell: UITableViewCell {
    
    /** 学生名 */
    @IBOutlet var labStuName: UILabel!
    /** 学号 */
    @IBOutlet var labStuNum: UILabel!
    /** 考勤状态 */
    @IBOutlet var labAttendanceState: UILabel!
    
    /** 考勤数据 */
    var dicStuAttData = Dictionary<String, AnyObject>()

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.labStuNum.text = self.dicStuAttData["studentNum"] as? String
        
        self.labStuName.text = self.dicStuAttData["studentName"] as? String
        
        switch self.dicStuAttData["attendanceState"] as! String {
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
    }

}
