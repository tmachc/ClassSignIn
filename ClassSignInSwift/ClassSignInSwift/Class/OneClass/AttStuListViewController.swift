//
//  AttStuListViewController.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/4/23.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class AttStuListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var table: UITableView!
    
    var dicAttendance = Dictionary<String, AnyObject>()
    var arrStuData = [Dictionary<String, AnyObject>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = self.dicAttendance["attendanceName"] as? String
        self.getOneAttendanceData()
    }
    
    // MARK: - function
    
    func getOneAttendanceData() {
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "getOneAttendanceData",
                "attendanceId": dicAttendance["attendanceId"]!
            ]) { (result) in
                self.dicAttendance = result["attendance"] as! Dictionary<String, AnyObject>
                self.arrStuData = self.dicAttendance["classMate"] as! Array
                self.table.reloadData()
        }
    }
    
    // MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStuData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AttStuListTableViewCell = tableView.dequeueReusableCellWithIdentifier("attStuListCell") as! AttStuListTableViewCell
        cell.dicStuAttData = arrStuData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /*
         1、旷课
         2、迟到
         3、请假
         4、出勤
         */
        let dic = arrStuData[indexPath.row]
        let alert = UIAlertController.init(title: "修改学生签到状态", message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        let attendance = UIAlertAction.init(title: "出勤", style: .Default) { aaa in
            self.changeState(state: "4", attendanceId: self.dicAttendance["attendanceId"] as! String, studentId: dic["studentId"] as! String)
        }
        let late = UIAlertAction.init(title: "迟到", style: .Default) { aaa in
            self.changeState(state: "2", attendanceId: self.dicAttendance["attendanceId"] as! String, studentId: dic["studentId"] as! String)
        }
        let leave = UIAlertAction.init(title: "请假", style: .Default) { aaa in
            self.changeState(state: "3", attendanceId: self.dicAttendance["attendanceId"] as! String, studentId: dic["studentId"] as! String)
        }
        let absent = UIAlertAction.init(title: "旷课", style: .Default) { aaa in
            self.changeState(state: "1", attendanceId: self.dicAttendance["attendanceId"] as! String, studentId: dic["studentId"] as! String)
        }
        let cancel = UIAlertAction.init(title: "取消", style: .Cancel, handler: nil)
        alert.addAction(attendance)
        alert.addAction(late)
        alert.addAction(leave)
        alert.addAction(absent)
        alert.addAction(cancel)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func changeState(state state: String, attendanceId: String, studentId: String) {
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "stuSignIn",
                "attendanceId": attendanceId,
                "studentId": studentId,
                "state": state
            ]) { (result) in
                self.getOneAttendanceData()
        }
    }
}
