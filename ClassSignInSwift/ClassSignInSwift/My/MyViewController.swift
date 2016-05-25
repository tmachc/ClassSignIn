//
//  MyViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/11/30.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit

class MyViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.table.tableFooterView = UIView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.table.reloadData()
    }
    
    @IBAction func logout(sender: UIButton) {
        
        userDefault.removeObjectForKey("num")
        userDefault.removeObjectForKey("_id")
        // 去登录
        self.parentViewController!.performSegueWithIdentifier("login", sender: nil)
    }
    
    // ********* MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "editMy" {
            let destinationController = segue.destinationViewController as! EditMyViewController
            destinationController.row = sender!.row
        }
    }
    
    // ********* MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("myCellID")! as UITableViewCell
        if indexPath.row == 0 {
            cell.textLabel?.text = "姓名: "
            cell.detailTextLabel?.text = userDefault.objectForKey("name") as? String
        }
        else if indexPath.row == 1 {
            if userDefault.objectForKey("type")!.isEqual("teacher") {
                cell.textLabel?.text = "学号: "
            }
            else {
                cell.textLabel?.text = "教职工号: "
            }
            cell.detailTextLabel?.text = userDefault.objectForKey("num") as? String
        }
        else if indexPath.row == 2 {
            cell.textLabel?.text = "性别: "
            cell.detailTextLabel?.text = userDefault.objectForKey("sex") as? String
        }
        else if indexPath.row == 3 {
            cell.textLabel?.text = "年龄: "
            cell.detailTextLabel?.text = userDefault.objectForKey("age") as? String
        }
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        self.performSegueWithIdentifier("editMy", sender: indexPath)
    }
}







