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
    @IBOutlet var activity: UIActivityIndicatorView!
    
    var arrClassData = [Dictionary<String, String>]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //
        arrClassData = [
            [
                "className": "高数",
                "teacherId": "韩老师",
                "classNum": "123456"
            ],
            [
                "className": "线代",
                "teacherId": "付老师",
                "classNum": "456789"
            ]
        ]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // ********* MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == "oneClass" {
            let destinationController = segue.destinationViewController as! OneClassController
            destinationController.dicClassData = arrClassData[sender!.row]
        }
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
            print(result["list"])
            self.arrClassData = result["list"] as! [Dictionary<String, String>]
            self.table.reloadData()
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
}
