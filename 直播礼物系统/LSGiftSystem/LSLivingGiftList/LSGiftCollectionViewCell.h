//
//  LSGiftCollectionViewCell.h
//  hong5
//
//  Created by 郭敬楠 on 17/4/19.
//  Copyright © 2017年 com.hong5.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSGiftCollectionViewCellModel.h"
@interface LSGiftCollectionViewCell : UICollectionViewCell
@property (nonatomic, strong) UIButton * button;

@property (nonatomic, strong) UIImageView * giftImageView;
@property (nonatomic, strong) UILabel * textLabel;
- (void) setCellData:(LSGiftCollectionViewCellModel *) cellData;
@end

