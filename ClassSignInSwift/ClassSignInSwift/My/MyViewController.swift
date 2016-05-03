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
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.table.reloadData()
    }
    
    @IBAction func logout(sender: UIButton) {
        
        userDefault.removeObjectForKey("num");
        userDefault.removeObjectForKey("_id");
        // 去登录
        self.parentViewController!.performSegueWithIdentifier("login", sender: nil)
    }
    
    // ********* MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: ClassTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCellID") as! ClassTableViewCell
        let cell = UITableViewCell.init()
        if indexPath.row == 0 {
            cell.textLabel?.text = "姓名: " + (userDefault.objectForKey("name") as! String)
        }
        else if indexPath.row == 1 {
            cell.textLabel?.text = "学号: " + (userDefault.objectForKey("num") as! String)
        }
        else if indexPath.row == 2 {
            cell.textLabel?.text = "性别: " + (userDefault.objectForKey("sex") as! String)
        }
        else if indexPath.row == 3 {
            cell.textLabel?.text = "年龄: " + (userDefault.objectForKey("age") as! String)
        }
        return cell
    }
    
}
