//
//  HomeworkTableViewCell.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/3/15.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {
    
    /** 作业名称 */
    @IBOutlet var labHomeworkName: UILabel!
    /** 作业截止时间 */
    @IBOutlet var labHomeworkDate: UILabel!
    /** 作业内容 */
    @IBOutlet var labHomeworkContent: UILabel!
    
    /** 作业数据 */
    var dicHomeworkData = Dictionary<String, String>()

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        self.labHomeworkName.text = dicHomeworkData["homeworkName"]
        self.labHomeworkDate.text = dicHomeworkData["homeworkDate"]
        self.labHomeworkContent.text = dicHomeworkData["homeworkContent"]
        if selected {
            self.selected = false  // 点击cell 选中效果立即消失
        }
        
        // Configure the view for the selected state
    }

}
