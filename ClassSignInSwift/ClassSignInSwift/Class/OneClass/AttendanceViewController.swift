//
//  AttendanceViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/1/5.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class AttendanceViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    var arrAttendanceData = [Dictionary<String, String>]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 获取考勤数据
        
        
        /* 
        1、旷课
        2、迟到
        3、请假
        4、出勤
        */
        arrAttendanceData = [
            [
                "attendanceName": "考勤1",
                "attendanceDate": "1月10日",
                "attendanceState": "1"
            ],
            [
                "attendanceName": "考勤2",
                "attendanceDate": "1月11日",
                "attendanceState": "2"
            ],
            [
                "attendanceName": "考勤3",
                "attendanceDate": "1月12日",
                "attendanceState": "4"
            ]
        ]
        
        
        // 刷新列表
        self.table.reloadData()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrAttendanceData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: AttendanceTableViewCell = tableView.dequeueReusableCellWithIdentifier("attendanceCellID") as! AttendanceTableViewCell
        cell.dicAttendanceData = arrAttendanceData[indexPath.row]
        return cell
    }
    
}
