//
//  LSLivingGiftListView.h
//  hong5
//
//  Created by 郭敬楠 on 17/4/19.
//  Copyright © 2017年 com.hong5.ios. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSGiftCollectionViewCell.h"
#import "LSCollectionViewFlowLayout.h"
static NSString * const cellID = @"LSGiftCollectionViewCell";
static NSString * const headerID = @"UICollectionElementKindSectionHeader";
static NSString * const footerID = @"UICollectionElementKindSectionFooter";
typedef void (^LSLivingGiftListViewBlock) (UIButton * button, LSGiftCollectionViewCellModel *giftModel);
@interface LSLivingGiftListView : UIView<UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
{
    LSGiftCollectionViewCellModel *oldGiftModel;//上次选中的礼物
}
@property (nonatomic, strong) UICollectionView * collectionView;
@property (nonatomic, strong) NSMutableArray * collectionViewDataSource;//为collectionView提供数据
@property (nonatomic, strong) UIView *backgroundView;
@property (nonatomic, strong) UILabel * yuanbaoLabel;
@property (nonatomic, strong) UILabel * scoreLabel;
@property (nonatomic, strong) UIButton * rechargeButton;
@property (nonatomic, strong) UIButton * sendButton;
@property (nonatomic, strong) LSLivingGiftListViewBlock block;

//设置当前金元宝和积分
- (void) setScoreYuanbao:(NSDictionary *) dic;

- (void) showInView:(UIView *) view;
- (void) hiddenView;

- (void) refreshGiftView;
@end
