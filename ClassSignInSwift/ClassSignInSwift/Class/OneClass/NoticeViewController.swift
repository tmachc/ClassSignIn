//
//  NoticeViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/1/5.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class NoticeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!
    
    var arrNoticeData = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // 获取通知数据
//        arrNoticeData = [
//            [
//                "noticeName": "放假",
//                "noticeDate": "1月10日 22:22",
//                "noticeContent": "不用回来了！！！！不用回来了！！！！不用回来了！！！！"
//            ],
//            [
//                "noticeName": "开学",
//                "noticeDate": "2月10日 22:22",
//                "noticeContent": "没作业！！！！没作业！！！！没作业！！！！"
//            ],
//            [
//                "noticeName": "考试",
//                "noticeDate": "3月10日 22:22",
//                "noticeContent": "开卷！！！！开卷！！！！开卷！！！！"
//            ]
//        ]
        
        // 刷新列表
        self.table.reloadData()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editNotice" {
            let destinationController = segue.destinationViewController as! EditNoticeViewController
            let oneClass = self.parentViewController as! OneClassController
            destinationController.classId = oneClass.dicClassData["classId"]!
        }
    }
    
    // MARK: - function
    
    func getNoticeListData() {
        
        let oneClass = self.parentViewController as! OneClassController
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: ["command": "getNoticeList", "classId": oneClass.dicClassData["classId"]!] ) { (result) -> Void in
                
                self.arrNoticeData = result["list"] as! [Dictionary<String, String>]
                self.table.reloadData()
        }
    }

    // MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrNoticeData.count
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: NoticeTableViewCell = tableView.dequeueReusableCellWithIdentifier("noticeCellID") as! NoticeTableViewCell
        cell.dicNoticeData = arrNoticeData[indexPath.row]
        return cell
    }
}
