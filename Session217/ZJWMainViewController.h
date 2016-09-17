//
//  ZJWMainViewController.h
//  Session217
//
//  Created by 周游世界的风 on 16/9/14.
//  Copyright © 2016年 JiWen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZJWMainViewController : UIViewController<UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIView *colorView;

@end
