//
//  SY_headerView.h
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SY_headerView : UICollectionReusableView
- (IBAction)m_taoBtn:(UIButton *)sender;
@property(nonatomic,strong)void(^tapBtnBlock)(NSInteger tag);
@end
