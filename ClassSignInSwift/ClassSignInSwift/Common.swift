//
//  Common.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/3/15.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import Foundation
import UIKit

/* 接口地址 */
//let HttpUrl = "http://localhost:7700/v1?"
let HttpUrl = "http://169.254.175.136:7700/v1?"

/* 用于储存信息 Dictionary */
let userDefault = NSUserDefaults.standardUserDefaults()

let WINDOW_WIDTH = UIScreen.mainScreen().bounds.size.width
let WINDOW_HIGHT = UIScreen.mainScreen().bounds.size.height

//获取label高度
func getSizeOfLabel(str str: String, width: CGFloat, height: CGFloat, font: UIFont) -> CGSize {
    let sizeline = CGSizeMake(width, height)
    let paragraphStyle = NSMutableParagraphStyle.init()
    paragraphStyle.lineBreakMode = NSLineBreakMode.ByWordWrapping
    let attributes = [NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle]
    let labelsize = str.boundingRectWithSize(sizeline, options: NSStringDrawingOptions.UsesLineFragmentOrigin, attributes: attributes, context: nil).size
    return labelsize
}

func RGBColor(r r:Int, g:Int, b:Int) -> UIColor {
    return UIColor.init(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: 1)
}

func ShowAlert(target target: UIViewController, message:String) {
    let alert = UIAlertController.init(title: "提示", message: message, preferredStyle: UIAlertControllerStyle.Alert)
    let cancel = UIAlertAction.init(title: "确定", style: .Cancel, handler: nil)
    alert.addAction(cancel)
    target.presentViewController(alert, animated: true, completion: nil)
}

