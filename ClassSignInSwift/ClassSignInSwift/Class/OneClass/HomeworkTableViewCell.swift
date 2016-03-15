//
//  HomeworkTableViewCell.swift
//  ClassSignInSwift
//
//  Created by tmachc on 16/3/15.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class HomeworkTableViewCell: UITableViewCell {
    
    /** 通知名称 */
    @IBOutlet var labHomeworkName: UILabel!
    /** 通知时间 */
    @IBOutlet var labHomeworkDate: UILabel!
    /** 通知内容 */
    @IBOutlet var labHomeworkContent: UILabel!
    
    /** 通知数据 */
    var dicHomeworkData = Dictionary<String, String>()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
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
