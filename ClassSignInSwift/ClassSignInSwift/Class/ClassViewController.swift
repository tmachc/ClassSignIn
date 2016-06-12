//
//  ClassViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/11/30.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit

class ClassViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet var table: UITableView!
    
    var refreshControl: UIRefreshControl!
    
    var arrClassData = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.refreshControl = UIRefreshControl.init()
        self.refreshControl.addTarget(self, action: #selector(getClassData), forControlEvents: UIControlEvents.ValueChanged)
        self.table.addSubview(self.refreshControl)
    }
    
    // ********* MARK: - function
    
    func getClassData() {
        HttpManager.defaultManager.getRequest(
            url: HttpUrl,
            params: [
                "command": "getClassList",
                "userId": userDefault.objectForKey("_id")!,
                "type": userDefault.objectForKey("type")!
            ])
        { (result) -> Void in
            if result["code"]!.isEqual(0) {
                self.arrClassData = result["list"] as! [Dictionary<String, String>]
                self.table.reloadData()
            }
            else {
                ShowAlert(target: self, message: result["message"] as! String)
            }
            self.refreshControl.endRefreshing()
        }
    }
    
    // ********* MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrClassData.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: ClassTableViewCell = tableView.dequeueReusableCellWithIdentifier("classCellID") as! ClassTableViewCell
        cell.dicClassData = arrClassData[indexPath.row]
        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.performSegueWithIdentifier("oneClass", sender: indexPath)
    }
    
    // ********* MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "oneClass" {
            let destinationController = segue.destinationViewController as! OneClassController
            destinationController.dicClassData = arrClassData[sender!.row]
        }
    }
    
    func addClass(sender: UIButton) {
        self.performSegueWithIdentifier("addNewClass", sender: nil)
    }
}
