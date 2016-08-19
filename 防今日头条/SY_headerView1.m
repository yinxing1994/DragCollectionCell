//
//  SY_headerView1.m
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import "SY_headerView1.h"

@implementation SY_headerView1

- (void)awakeFromNib {
    // Initialization code
    
    self.m_bacView.layer.cornerRadius = 4;
    self.m_bacView.layer.masksToBounds = YES;
    [self changeBtnStates];
}
-(void)changeBtnStates{
    
}
- (IBAction)m_goodsBtn:(UIButton *)sender {
    
  self.m_goodsClickBlock(sender.tag);
    
}

- (IBAction)m_dreamBtn:(UIButton *)sender {
    
    self.m_dreamClickBlock(sender.tag);
  
}

- (IBAction)m_socialBtn:(UIButton *)sender {
    
    self.m_socialClickBlock(sender.tag);
   
}
@end
