//
//  ZJWCollectionViewCell.m
//  Session217
//
//  Created by 周游世界的风 on 16/9/14.
//  Copyright © 2016年 JiWen. All rights reserved.
//

#import "ZJWCollectionViewCell.h"

#define PULL_THREHOLD 120.f

@interface ZJWCollectionViewCell ()<UIScrollViewDelegate>
{
    UIScrollView *_scrollView;
    UIView *_colorView;

    BOOL _pulling;
    BOOL _deceleratingBackToZero;
    CGFloat _decelerationDistanceRatio;
}
@end

@implementation ZJWCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if ( self ) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];
        
        _colorView = [[UIView alloc] init];
        [_scrollView addSubview:_colorView];
    }
    return self;
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    CGFloat offset = scrollView.contentOffset.x;
    
    if (offset > PULL_THREHOLD  && !_pulling) {
        [_delegate scrollingCellDidBeginPulling:self];
        _pulling = YES;
    }
    
    if (_pulling) {
        CGFloat pullOffset;
        
        if (_deceleratingBackToZero) {
            pullOffset =  offset * _decelerationDistanceRatio;
        } else {
            pullOffset = MAX(0, offset - PULL_THREHOLD);
        }
        
        [_delegate scrollingCell:self didChangePullOffset:pullOffset];
        _scrollView.transform = CGAffineTransformMakeTranslation(pullOffset, 0);
    }
}

- (void) scrollEnded
{
    [_delegate scrollingCellDidEndPulling:self];
    _pulling = NO;
    _deceleratingBackToZero = NO;
    
    _scrollView.transform = CGAffineTransformIdentity;
    _scrollView.contentOffset = CGPointZero;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) {
        [self scrollEnded];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollEnded];
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    CGFloat offset = scrollView.contentOffset.x;
    
    if ( (*targetContentOffset).x == 0 && offset > 0) {
        _deceleratingBackToZero = YES;
        
        CGFloat pullOffset = MAX(0, offset - PULL_THREHOLD);
        _decelerationDistanceRatio = pullOffset / offset;
    }
}

- (void)setColor:(UIColor *)color
{
    _color = color;
    _colorView.backgroundColor = color;
}

- (void)layoutSubviews
{
    UIView *contentView = self.contentView;
    CGRect bounds = contentView.bounds;
    
    CGFloat pageWidth = bounds.size.width + PULL_THREHOLD;
    _scrollView.frame = CGRectMake(0, 0, pageWidth, bounds.size.height);
    _scrollView.contentSize = CGSizeMake(pageWidth * 2, bounds.size.height);
    
    _colorView.frame = [_scrollView convertRect:bounds fromView:contentView];
}

@end
