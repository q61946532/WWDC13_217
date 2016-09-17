//
//  ZJWSpringFlowLayout.m
//  Session217
//
//  Created by 周游世界的风 on 16/9/16.
//  Copyright © 2016年 JiWen. All rights reserved.
//

#import "ZJWSpringFlowLayout.h"

@interface ZJWSpringFlowLayout ()
{
    UIDynamicAnimator *_dynamicAnimator;
}
@end

@implementation ZJWSpringFlowLayout

-(void)prepareLayout
{
    [super prepareLayout];
    
    if (!_dynamicAnimator) {
        _dynamicAnimator = [[UIDynamicAnimator alloc] initWithCollectionViewLayout:self];
        
        CGSize contentSize = [self collectionViewContentSize];
        NSArray *items = [super layoutAttributesForElementsInRect:CGRectMake(0, 0, contentSize.width, contentSize.height)];
        
        for (UICollectionViewLayoutAttributes *item in items) {
            UIAttachmentBehavior *spring = [[UIAttachmentBehavior alloc] initWithItem:item attachedToAnchor:[item center]];
            spring.length = 0;
            spring.damping = 0.5;
            spring.frequency = 0.8;
            [_dynamicAnimator addBehavior:spring];
        }
    }
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return [_dynamicAnimator itemsInRect:rect];
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return [_dynamicAnimator layoutAttributesForCellAtIndexPath:indexPath];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    UIScrollView *scrollview = self.collectionView;
    CGFloat scrollDelta = newBounds.origin.y - scrollview.bounds.origin.y;
    CGPoint touchLocation = [scrollview.panGestureRecognizer locationInView:scrollview];
    
    for (UIAttachmentBehavior *spring in _dynamicAnimator.behaviors) {
        CGPoint anchorPoint = spring.anchorPoint;
        CGFloat distanceFromTouch = fabs(touchLocation.y  - anchorPoint.y);
        CGFloat scrollResistance = distanceFromTouch / 500;
        
        UICollectionViewLayoutAttributes *item = [spring.items firstObject];
        CGPoint center = item.center;
        center.y += scrollDelta * scrollResistance;
        item.center = center;
        
        [_dynamicAnimator updateItemUsingCurrentState:item];
    }
    return NO;
}

@end
