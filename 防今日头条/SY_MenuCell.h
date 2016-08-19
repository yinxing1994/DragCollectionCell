//
//  SY_MenuCell.h
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SY_MenuCell : UICollectionViewCell
@property (strong, nonatomic) IBOutlet UIButton *m_cellBtn;
- (IBAction)m_tapCellBtn:(UIButton *)sender;
@property(nonatomic,strong)void (^cellClickBlock)(NSInteger index);

@end
