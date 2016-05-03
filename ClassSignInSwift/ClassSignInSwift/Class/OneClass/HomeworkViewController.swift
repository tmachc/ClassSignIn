//
//  HomeworkViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/1/5.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var table: UITableView!
    
    var arrHomeworkData = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 获取通知数据
        self.getHomeworkListData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editHomework" {
            let destinationController = segue.destinationViewController as! EditHomeworkViewController
            let oneClass = self.parentViewController as! OneClassController
            destinationController.classId = oneClass.dicClassData["classId"]!
            if sender != nil {
                let dic = self.arrHomeworkData[sender!.row]
                destinationController.homeworkId = dic["homeworkId"]!
                destinationController.dicHomeworkData = dic as Dictionary<String, String>
            }
        }
    }
    
    // ********* MARK: - function
    
    func getHomeworkListData() {
        let oneClassVC = self.parentViewController as! OneClassController
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "getHomeworkList",
                "userId": userDefault.objectForKey("_id")!,
                "classId": oneClassVC.dicClassData["classId"]!
            ])
            { (result) -> Void in
                self.arrHomeworkData = result["list"] as! [Dictionary<String, String>]
                self.table.reloadData()
        }
    }
    
    // MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrHomeworkData.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: HomeworkTableViewCell = tableView.dequeueReusableCellWithIdentifier("homeworkCellID") as! HomeworkTableViewCell
        cell.dicHomeworkData = arrHomeworkData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if userDefault.objectForKey("type")!.isEqual("teacher"){
            self.performSegueWithIdentifier("editHomework", sender: indexPath)
        }
    }

}
