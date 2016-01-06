//
//  LoginViewController.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/11/27.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    @IBOutlet var tfUserName: UITextField!
    
    @IBOutlet var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        // Do any additional setup after loading the view.
       
    }
    
    @IBAction func clickLogin(sender: UIButton) {
        //
    
    
    
    
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
