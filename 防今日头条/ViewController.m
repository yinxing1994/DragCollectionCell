//
//  ViewController.m
//  防今日头条
//
//  Created by 尹星 on 16/8/18.
//  Copyright © 2016年 尹星. All rights reserved.
//

#import "ViewController.h"
#import "SY_headerView1.h"
#import "SY_headerView.h"
#import "SY_MenuCell.h"
#import "MenuLineLayout.h"

#define SCREEN_WIDTH CGRectGetWidth([[UIScreen mainScreen] bounds])
#define SCREEN_HEIGHT CGRectGetHeight([[UIScreen mainScreen] bounds])

@interface ViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSMutableArray * topArray;//顶部菜单
    
    NSMutableArray * goodsArray;//产品筹标签
    NSMutableArray * dreamArray;//梦想筹标签
    NSMutableArray * socialArray;//公益筹标签
    
    NSMutableArray * sectin2Array;//存放bottom标签临时数组
    
    NSString * topMenuhandle;//排序还是删除操作
    
    UILongPressGestureRecognizer *longPress ;
    BOOL isEditing;
    SY_headerView1 * h1;
}
@property (nonatomic,strong) UICollectionView * m_bodyCollection;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self requestLabelInfor];
    
    topMenuhandle = @"delete";//默认执行删除操作
    
    [self createCollectionView];
    isEditing = NO;
}

-(void)requestLabelInfor{

    if (!topArray) {
        topArray = [[NSMutableArray alloc]init];
        topArray = [NSMutableArray arrayWithArray:@[@[@"北京",@"0"],@[@"上海",@"1"],@[@"深圳",@"2"],@[@"杭州",@"0"],@[@"广州",@"1"]]];
        
    }
    
    if (!goodsArray) {
        goodsArray = [[NSMutableArray alloc]init];
        goodsArray = [NSMutableArray arrayWithArray:@[@[@"产品1",@"0"],@[@"产品2",@"0"],@[@"产品3",@"0"],@[@"产品4",@"0"]]];
    }
    
    if (!dreamArray) {
        dreamArray = [[NSMutableArray alloc]init];
        dreamArray = [NSMutableArray arrayWithArray:@[@[@"梦想1",@"1"],@[@"梦想2",@"1"],@[@"梦想3",@"1"],@[@"梦想4",@"1"],@[@"梦想5",@"1"],@[@"梦想6",@"1"],@[@"梦想7",@"1"]]];
    }
    
    if (!socialArray) {
        socialArray = [NSMutableArray arrayWithArray:@[@[@"公益1",@"2"],@[@"公益1",@"2"],@[@"公益2",@"2"],@[@"公益3",@"2"],@[@"公益4",@"2"],@[@"公益5",@"2"],@[@"公益6",@"2"],@[@"公益7",@"2"],@[@"公益8",@"2"],@[@"公益9",@"2"],@[@"公益10",@"2"],]];
    }
    
    
    if (!sectin2Array) {
        sectin2Array = [[NSMutableArray alloc]init];
        sectin2Array = goodsArray;
    }

}
#pragma mark - 创建collectioView
-(void)createCollectionView{

    self.m_bodyCollection = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:[[MenuLineLayout alloc] init]];
    self.m_bodyCollection.backgroundColor = [UIColor clearColor];
    self.m_bodyCollection.delegate = self;
    self.m_bodyCollection.dataSource = self;
    
    [self.m_bodyCollection registerNib:[UINib nibWithNibName:@"SY_headerView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader0"];
    
    [self.m_bodyCollection registerNib:[UINib nibWithNibName:@"SY_headerView1" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader1"];
    
    [self.m_bodyCollection registerNib:[UINib nibWithNibName:@"SY_MenuCell" bundle:nil] forCellWithReuseIdentifier:@"CollectionCell"];
    [self.view addSubview:self.m_bodyCollection];
    [self.m_bodyCollection reloadData];
    
    //创建长按手势监听
    longPress = [[UILongPressGestureRecognizer alloc]
                                               initWithTarget:self
                                               action:@selector(myHandleTableviewCellLongPressed:)];
    longPress.minimumPressDuration = 0.7;
    
    
}
#pragma mark - 排序
- (void) myHandleTableviewCellLongPressed:(UILongPressGestureRecognizer *)gestureRecognizer {

    NSIndexPath *indexPath = [self.m_bodyCollection indexPathForItemAtPoint:[longPress locationInView:self.m_bodyCollection]];
    
    //判断手势状态
    switch (longPress.state) {
            
        case UIGestureRecognizerStateBegan:{
            
            //判断手势落点位置是否在路径上
          
            //在路径上则开始移动该路径上的cell
            [self.m_bodyCollection beginInteractiveMovementForItemAtIndexPath:indexPath];
        }
            break;
        case UIGestureRecognizerStateChanged:
        
           
            //移动过程当中随时更新cell位置
            [self.m_bodyCollection updateInteractiveMovementTargetPosition:[longPress locationInView:self.m_bodyCollection]];
            break;
        case UIGestureRecognizerStateEnded:
           
            //移动结束后关闭cell移动
            [self.m_bodyCollection endInteractiveMovement];
            
            break;
        default:
            [self.m_bodyCollection cancelInteractiveMovement];
            break;
    }
}
- (BOOL)collectionView:(UICollectionView *)collectionView canMoveItemAtIndexPath:(NSIndexPath *)indexPath{
    if (isEditing) { // 编辑中
        if (indexPath.section == 0 && indexPath.row < 1) {
            return NO;
        }
        if ([collectionView numberOfItemsInSection:indexPath.section] <= 1) {
            return NO;
        }
        return YES;
    } else {
        return NO;
    }
}
- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(nonnull NSIndexPath *)sourceIndexPath toIndexPath:(nonnull NSIndexPath *)destinationIndexPath
{
    
    
//        NSIndexPath * selectIndexPath = [self.m_bodyCollection indexPathForItemAtPoint:[longPress locationInView:self.m_bodyCollection]];
//        // 找到当前的cell
//        SY_MenuCell *cell = (SY_MenuCell *)[self.m_bodyCollection cellForItemAtIndexPath:selectIndexPath];
    
        [topArray exchangeObjectAtIndex:sourceIndexPath.item withObjectAtIndex:destinationIndexPath.item];

     [UIView performWithoutAnimation:^{
         
         [self.m_bodyCollection reloadData];
         
     }];
    
    
}
#pragma mark <UICollectionViewDataSource>
#pragma mark - collection 有几个section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    //如果处于可编辑状态
    if (isEditing) {

        
        //将长按手势添加到需要实现长按操作的视图里
        [self.m_bodyCollection addGestureRecognizer:longPress];
        return 1;
    }

    //移除手势
    [self.m_bodyCollection removeGestureRecognizer:longPress];
    return 2;
}

#pragma mark - collection每段有几个item
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return topArray.count;
    }
    
    return sectin2Array.count;
}

#pragma mark - collection 每个item的cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    __weak typeof(self) unself = self;

    SY_MenuCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CollectionCell" forIndexPath:indexPath];
    
    if (indexPath.section == 0) {
        
        [cell.m_cellBtn setTitle:topArray[indexPath.item][0] forState:UIControlStateNormal];
        
        cell.cellClickBlock = ^(NSInteger index){
            //删除操作
            if (!isEditing) {
                
                //点击section0item 先刷新表 在执行动画
                [UIView animateWithDuration:0.1 animations:^{
                    
                    NSString * str = topArray[indexPath.item][1];
                    [unself changeFooterMenu:[str intValue]];//改变footerMenu的显示标签
                    [unself changeSectionHeaderBtn:[str intValue]];
                }completion:^(BOOL finished) {
                    
                    NSString * kind = topArray[indexPath.item][1];
                    [unself returnLabelFromTopMenu:indexPath.item kind:[kind intValue]];//从topMenu中回退标签
                    
                }];
                
            }
            
        };
        
}
    else if (indexPath.section == 1){
    
        [cell.m_cellBtn setTitle:sectin2Array[indexPath.item][0] forState:UIControlStateNormal];
       
        cell.cellClickBlock = ^(NSInteger index){
  
            index = indexPath.item;
            
            [unself addFooterMenuToTopMenu:index];//向topMenu中添加标签
            
        };
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
#pragma mark - collectionview每个item的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake(SCREEN_WIDTH/4-15,35);
    
}

#pragma mark -collectionView 每个item的间距
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 0) {
        return UIEdgeInsetsMake(0, 10, 10, 10);
    }
    
    return UIEdgeInsetsMake(10, 10, 10, 10);
}

#pragma mark - collectionView的sectionHeader的size
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    return CGSizeMake(SCREEN_WIDTH, 90);
}

#pragma mark - collectionView sectionHeader

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    __weak typeof (self)unself = self;
    if (indexPath.section == 0) {
        
        SY_headerView * h0;
        if([kind isEqual:UICollectionElementKindSectionHeader])
        {
            h0 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader0" forIndexPath:indexPath];
         
        }
        h0.tapBtnBlock = ^(NSInteger tag){
        
            if (tag == 0) {
                
                isEditing = NO;
                [unself.m_bodyCollection reloadData];
            }
            else if (tag == 1){
            
                isEditing = YES;
                [unself.m_bodyCollection reloadData];
                
            }
            
        };
        return h0;
    }
   
    else if (indexPath.section == 1){
    
       
        if([kind isEqual:UICollectionElementKindSectionHeader])
        {
            h1 = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"CollectionHeader1" forIndexPath:indexPath];
            
        }
        h1.m_goodsClickBlock = ^(NSInteger index){
        
            index = 0;
            [unself changeFooterMenu:index];//点击标签改变bottomMenu
        };
        h1.m_dreamClickBlock = ^(NSInteger index){
            
            index = 1;
            [unself changeFooterMenu:index];//点击标签改变bottomMenu
        };
        h1.m_socialClickBlock = ^(NSInteger index){
            
            index = 2;
            [unself changeFooterMenu:index];//点击标签改变bottomMenu
        };
        if (!isEditing) {
         
             h1.hidden = NO;
        }
        else if (isEditing){
             h1.hidden = YES;
        }
        return h1;
    }
    
    return nil;
}

#pragma mark - 点击标签改变bottomMenu
-(void)changeFooterMenu:(NSInteger)index{

    __weak typeof (self)unself = self;
    
    if (index == 0) {
        
        sectin2Array = goodsArray;
        
    }
    else if (index == 1){
        
        sectin2Array = dreamArray;
        
    }
    else if (index == 2){
        
        sectin2Array = socialArray;
        
    }
    
    [UIView performWithoutAnimation:^{
        
        [unself.m_bodyCollection reloadSections:[NSIndexSet indexSetWithIndex:1]];
        [self changeSectionHeaderBtn:index];//改变sectionHeader按钮状态
    }];

}

#pragma mark - 改变sectionHeader中按钮状态
-(void)changeSectionHeaderBtn:(NSInteger)index{

    h1.m_dream.selected = NO;
    [h1.m_dream setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    h1.m_dream.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    h1.m_goods.selected = NO;
    [h1.m_goods setTitleColor:[UIColor blackColor] forState:UIControlStateNormal ];
    h1.m_goods.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    h1.m_social.selected = NO;
    [h1.m_social setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    h1.m_social.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    //点击了产品筹
    if (index == 0) {
        
        h1.m_goods.selected = YES;
        [h1.m_goods setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        h1.m_goods.backgroundColor = [UIColor orangeColor];
    }
    //点击了梦想筹
    else if (index == 1){
    
        h1.m_dream.selected = YES;
        [h1.m_dream setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        h1.m_dream.backgroundColor = [UIColor orangeColor];
    }
    //点击了公益筹
    else if (index == 2){
        
        h1.m_social.selected = YES;
        [h1.m_social setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        h1.m_social.backgroundColor = [UIColor orangeColor];
    }
    
}
#pragma mark - 向topMenu中添加标签
-(void)addFooterMenuToTopMenu:(NSInteger)index{
    
    __weak typeof (self)unself = self;

    [UIView animateWithDuration:1.0 animations:^{
        
        [topArray addObject:sectin2Array[index]];
        
        if ([sectin2Array[index][1] isEqualToString:@"0"]) {
            
            [goodsArray removeObjectAtIndex:index];
            sectin2Array = goodsArray;
            
        }
        else if ([sectin2Array[index][1] isEqualToString:@"1"]) {
            [dreamArray removeObjectAtIndex:index];
            sectin2Array = dreamArray;
        }
        
        else if ([sectin2Array[index][1] isEqualToString:@"2"]) {
            [socialArray removeObjectAtIndex:index];
            sectin2Array = socialArray;
        }
        
    } completion:^(BOOL finished) {
        
        [unself.m_bodyCollection performBatchUpdates:^{
            
            [unself.m_bodyCollection moveItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:1] toIndexPath:[NSIndexPath indexPathForItem:topArray.count - 1 inSection:0]];
            
        } completion:^(BOOL finished) {
            
            [unself.m_bodyCollection  reloadData];
            
        }];
        
    }];

}

#pragma mark - 从topMenu中回退标签
-(void)returnLabelFromTopMenu:(NSInteger)index kind:(NSInteger)kind{

    __weak typeof (self)unself = self;
    if (kind == 0) {
        
        [goodsArray addObject:topArray[index]];
        [topArray removeObjectAtIndex:index];
        sectin2Array = goodsArray;
        
    }
    else if (kind == 1){
        
        [dreamArray addObject:topArray[index]];
        [topArray removeObjectAtIndex:index];
        sectin2Array = dreamArray;

    }
    else if (kind == 2){
        
        [socialArray addObject:topArray[index]];
        [topArray removeObjectAtIndex:index];
        sectin2Array = socialArray;
        
    }
    
    [unself.m_bodyCollection performBatchUpdates:^{
        
        [unself.m_bodyCollection moveItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] toIndexPath:[NSIndexPath indexPathForItem:sectin2Array.count-1 inSection:1]];
        
    } completion:^(BOOL finished) {
        
        [unself.m_bodyCollection reloadData];
        
    }];


    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
