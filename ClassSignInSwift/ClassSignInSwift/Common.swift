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
let HttpUrl = "http://localhost:7700/v1?"
//let HttpUrl = "http://169.254.68.141:7700/v1?"

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

