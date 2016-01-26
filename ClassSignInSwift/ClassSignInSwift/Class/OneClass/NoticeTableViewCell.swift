//
//  NoticeTableViewCell.swift
//  ClassSignInSwift
//
//  Created by 韩冲 on 16/1/10.
//  Copyright © 2016年 tmachc. All rights reserved.
//

import UIKit

class NoticeTableViewCell: UITableViewCell {

    /** 通知名称 */
    @IBOutlet var labNoticeName: UILabel!
    /** 通知时间 */
    @IBOutlet var labNoticeDate: UILabel!
    /** 通知内容 */
    @IBOutlet var labNoticeContent: UILabel!
    
    /** 通知数据 */
    var dicNoticeData = Dictionary<String, String>()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        self.labNoticeName.text = dicNoticeData["noticeName"]
        self.labNoticeDate.text = dicNoticeData["noticeDate"]
        self.labNoticeContent.text = dicNoticeData["noticeContent"]
        if selected {
            self.selected = false  // 点击cell 选中效果立即消失
        }
        
        // Configure the view for the selected state
    }

}
