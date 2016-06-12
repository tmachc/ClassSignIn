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
    
    var refreshControl: UIRefreshControl!
    
    var arrAttendanceData = [Dictionary<String, AnyObject>]()
    var classId = ""
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.refreshControl = UIRefreshControl.init()
        self.refreshControl.addTarget(self, action: #selector(getAttendanceList), forControlEvents: UIControlEvents.ValueChanged)
        self.table.addSubview(self.refreshControl)
        
        self.table.tableFooterView = UIView()
        
        // 获取考勤数据
        
        
        /* 
        1、旷课
        2、迟到
        3、请假
        4、出勤
        */
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.getAttendanceList), name: "reloadList", object: nil)
    }
    
    override func removeFromParentViewController() {
        super.removeFromParentViewController()
        NSNotificationCenter.defaultCenter().removeObserver(self, name: "reloadList", object: nil)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "attendanceList" {
            let destinationController = segue.destinationViewController as! AttStuListViewController
            destinationController.dicAttendance = sender as! Dictionary<String, AnyObject>
        }
        if segue.identifier == "addAttendence" {
            let destinationController = segue.destinationViewController as! AddNewAttViewController
            destinationController.classId = self.classId
        }
    }
    
    // MARK: - function
    
    func getAttendanceList() {
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "getAttendanceList",
                "classId": self.classId,
                "userId": userDefault.objectForKey("_id")!,
                "type": userDefault.objectForKey("type")!
            ])
        { (result) -> Void in
            if result["code"]!.isEqual(0) {
                self.arrAttendanceData = result["list"] as! [Dictionary<String, AnyObject>]
                self.table.reloadData()
                self.refreshControl.endRefreshing()
            }
            else {
                ShowAlert(target: self, message: result["message"] as! String)
            }
        }
    }

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
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if userDefault.objectForKey("type")!.isEqual("teacher")  {
            let dicAttendance = arrAttendanceData[indexPath.row]
            self.performSegueWithIdentifier("attendanceList", sender: dicAttendance)
        }
    }
}
