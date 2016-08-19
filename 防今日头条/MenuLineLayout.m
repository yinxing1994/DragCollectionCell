//
//  MenuLineLayout.m
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import "MenuLineLayout.h"

#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

@implementation MenuLineLayout

-(id)init
{
    self = [super init];
    if (self) {
        self.itemSize = CGSizeMake(SCREEN_WIDTH/4, SCREEN_WIDTH/4);
        self.scrollDirection = UICollectionViewScrollDirectionVertical;
        self.sectionInset = UIEdgeInsetsMake(0, 10, 0, 0);
        self.minimumLineSpacing = 10.0;
        self.minimumInteritemSpacing = 1.0;
    }
    return self;
}
@end
