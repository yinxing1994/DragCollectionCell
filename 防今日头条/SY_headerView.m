//
//  SY_headerView.m
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import "SY_headerView.h"

@implementation SY_headerView

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)m_taoBtn:(UIButton *)sender {
    
    if (sender.selected) {
        sender.selected = NO;
        sender.tag = 0;
        self.tapBtnBlock(sender.tag);
    }
    else{
        sender.selected = YES;
        sender.tag = 1;
        self.tapBtnBlock(sender.tag);
    }
}
@end
