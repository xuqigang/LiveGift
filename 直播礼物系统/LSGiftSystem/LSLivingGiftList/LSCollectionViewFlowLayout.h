//
//  LSCollectionViewFlowLayout.h
//  UICollectionView进阶
//
//  Created by 郭敬楠 on 17/4/19.
//  Copyright © 2017年 xuqigang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LSCollectionViewFlowLayout : UICollectionViewFlowLayout
// 一行中 cell的个数
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;
@end
