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
        
        print(superclass)
        print(self.parentViewController)
        
        // 获取通知数据
        arrHomeworkData = [
            [
                "homeworkName": "放假",
                "homeworkDate": "1月10日 22:22",
                "homeworkContent": "没作业！！！！"
            ],
            [
                "homeworkName": "开学",
                "homeworkDate": "2月10日 22:22",
                "homeworkContent": "没作业！！！！没作业！！！！"
            ],
            [
                "homeworkName": "考试",
                "homeworkDate": "3月10日 22:22",
                "homeworkContent": "没作业！！！！没作业！！！！没作业！！！！"
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
    
    // ********* MARK: - function
    
    func getHomeworkListData() {
        let oneClassVC = self.parentViewController as! OneClassController
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: ["command": "getHomeworkList", "userId": userDefault.objectForKey("_id")!, "classId": oneClassVC.dicClassData["classId"]!])
            { (result) -> Void in
                print(result["list"])
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

}
