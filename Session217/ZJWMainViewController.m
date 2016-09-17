//
//  ZJWMainViewController.m
//  Session217
//
//  Created by 周游世界的风 on 16/9/14.
//  Copyright © 2016年 JiWen. All rights reserved.
//

#import "ZJWMainViewController.h"
#import "ZJWCollectionViewCell.h"
#import "ZJWSpringFlowLayout.h"

#define ScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)

@interface ZJWMainViewController ()<ZJWCollectionViewCellDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation ZJWMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    
    ZJWSpringFlowLayout *flowLayout = [[ZJWSpringFlowLayout alloc] init];
    flowLayout.itemSize = CGSizeMake(ScreenWidth, 50);
    _collectionView.collectionViewLayout = flowLayout;
    [_collectionView registerClass:[ZJWCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];

}


- (void)scrollingCellDidBeginPulling:(ZJWCollectionViewCell *)cell
{
    _scrollView.scrollEnabled = NO;
    _colorView.backgroundColor = cell.color;
}

- (void)scrollingCell:(ZJWCollectionViewCell *)cell didChangePullOffset:(CGFloat)offset
{
    _scrollView.contentOffset = CGPointMake(offset, 0);
}

- (void)scrollingCellDidEndPulling:(ZJWCollectionViewCell *)cell
{
    _scrollView.scrollEnabled = YES;
}


- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 80;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ZJWCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    cell.color = [self randomBuildingColor];
    cell.delegate = self;
    
    return cell;
    
}

- (UIColor *) randomBuildingColor
{
    NSArray *colorArray = @[[UIColor redColor],[UIColor greenColor],[UIColor blueColor],[UIColor purpleColor],[UIColor yellowColor],[UIColor grayColor],[UIColor orangeColor],[UIColor blackColor]];
    
    
    NSUInteger index = arc4random() % colorArray.count;
    
    return colorArray[index];
}

@end
