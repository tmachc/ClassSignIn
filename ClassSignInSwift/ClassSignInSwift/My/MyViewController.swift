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
    
    // ********* MARK: - table
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        let cell: ClassTableViewCell = tableView.dequeueReusableCellWithIdentifier("myCellID") as! ClassTableViewCell
        let cell = UITableViewCell.init()
        cell.textLabel?.text = "退出登录"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        if indexPath.row == 0 {
            userDefault.removeObjectForKey("num");
            userDefault.removeObjectForKey("_id");
            // 去登录
            self.parentViewController!.performSegueWithIdentifier("login", sender: nil)
        }
    }
}
