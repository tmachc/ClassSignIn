//
//  OneClassController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/1/4.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class OneClassController: UITabBarController {
    
    var dicClassData = Dictionary<String, String>()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = dicClassData["className"]

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

}
