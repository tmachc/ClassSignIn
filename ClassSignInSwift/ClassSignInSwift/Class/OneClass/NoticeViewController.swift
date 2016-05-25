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
    
    var refreshControl: UIRefreshControl!
    
    var arrNoticeData = [Dictionary<String, String>]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl.init()
        self.refreshControl.addTarget(self, action: #selector(getNoticeListData), forControlEvents: UIControlEvents.ValueChanged)
        self.table.addSubview(self.refreshControl)
        
        // 去掉底下没有数据的cell
        self.table.tableFooterView = UIView.init()

        // 获取通知数据
        self.getNoticeListData()
        
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
            if sender != nil {
                let dic = self.arrNoticeData[sender!.row]
                destinationController.noticeId = dic["noticeId"]!
                destinationController.dicNoticeData = dic as Dictionary<String, String>
            }
        }
    }
    
    // MARK: - function
    
    func getNoticeListData() {
        
        let oneClass = self.parentViewController as! OneClassController
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "getNoticeList",
                "classId": oneClass.dicClassData["classId"]!
            ])
        { (result) -> Void in
            if result["code"]!.isEqual(0) {
                self.arrNoticeData = result["list"] as! [Dictionary<String, String>]
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
        return arrNoticeData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let size = getSizeOfLabel(str: arrNoticeData[indexPath.row]["noticeContent"]!, width: WINDOW_WIDTH - 24, height: CGFloat.max, font: UIFont.systemFontOfSize(16))
        return 24 + 30 + size.height + 6 + size.height/15
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: NoticeTableViewCell = tableView.dequeueReusableCellWithIdentifier("noticeCellID") as! NoticeTableViewCell
        cell.dicNoticeData = arrNoticeData[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if userDefault.objectForKey("type")!.isEqual("teacher"){
            self.performSegueWithIdentifier("editNotice", sender: indexPath)
        }
    }
}
