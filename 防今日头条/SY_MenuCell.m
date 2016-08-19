//
//  SY_MenuCell.m
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import "SY_MenuCell.h"

@implementation SY_MenuCell

- (void)awakeFromNib {
    // Initialization code
}

- (IBAction)m_tapCellBtn:(UIButton *)sender {
    
    self.cellClickBlock(sender.tag);
}
@end
