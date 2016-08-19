//
//  SY_headerView1.h
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SY_headerView1 : UICollectionReusableView
@property (strong, nonatomic) IBOutlet UIView *m_bacView;
-(void)changeBtnStates;
- (IBAction)m_goodsBtn:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIButton *m_goods;
@property(nonatomic,strong)void(^m_goodsClickBlock)(NSInteger sender);

- (IBAction)m_dreamBtn:(UIButton *)sender;
@property(nonatomic,strong)void(^m_dreamClickBlock)(NSInteger sender);
@property (strong, nonatomic) IBOutlet UIButton *m_dream;

- (IBAction)m_socialBtn:(UIButton *)sender;
@property(nonatomic,strong)void(^m_socialClickBlock)(NSInteger sender);
@property (strong, nonatomic) IBOutlet UIButton *m_social;
@end
