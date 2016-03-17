//
//  ClassTableViewCell.swift
//  ClassSignInSwift
//
//  Created by tmachc on 15/12/4.
//  Copyright © 2015年 tmachc. All rights reserved.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

    /** 课名 */
    @IBOutlet var labClassName: UILabel!
    /** 老师 */
    @IBOutlet var labTeacher: UILabel!
    /** 课程id */
    @IBOutlet var labClassID: UILabel!
    
    /** 课程数据 */
    var dicClassData = Dictionary<String, String>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // 加载数据
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        labClassName.text = dicClassData["className"]
        labClassID.text = dicClassData["classId"]
        labTeacher.text = dicClassData["teacher"]
        if selected {
            self.selected = false  // 点击cell 选中效果立即消失
        }
    }

}
