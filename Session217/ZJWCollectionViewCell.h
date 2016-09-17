//
//  ZJWCollectionViewCell.h
//  Session217
//
//  Created by 周游世界的风 on 16/9/14.
//  Copyright © 2016年 JiWen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZJWCollectionViewCell;
@protocol ZJWCollectionViewCellDelegate <NSObject>

- (void) scrollingCellDidBeginPulling:(ZJWCollectionViewCell *)cell;
- (void) scrollingCell:(ZJWCollectionViewCell *)cell didChangePullOffset:(CGFloat)offset;
- (void) scrollingCellDidEndPulling:(ZJWCollectionViewCell *)cell;

@end

@interface ZJWCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIColor *color;

@property (nonatomic,weak) id<ZJWCollectionViewCellDelegate> delegate;

@end
