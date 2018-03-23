//
//  LSLivingGiftListView.m
//  hong5
//
//  Created by 郭敬楠 on 17/4/19.
//  Copyright © 2017年 com.hong5.ios. All rights reserved.
//

#import "LSLivingGiftListView.h"

@implementation LSLivingGiftListView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundView = [[UIView alloc] init];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        [self addSubview:self.backgroundView];
        self.backgroundView.frame = CGRectMake(0, self.frame.size.height, self.frame.size.width, (self.frame.size.width-3)/4.0 *2 + 1 + UIScale(63) + 20);

        self.collectionViewDataSource = [NSMutableArray arrayWithCapacity:1];
//        [self.collectionViewDataSource addObjectsFromArray:array0];
        [self.backgroundView addSubview:self.collectionView];
        
        UIView * blackbackgroundView = [[UIView alloc] init];
        blackbackgroundView.userInteractionEnabled = YES;
        blackbackgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.82];
        [self.backgroundView addSubview:blackbackgroundView];
        [blackbackgroundView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.bottom.mas_equalTo(0);
            make.top.mas_equalTo(self.collectionView.mas_bottom).mas_offset(0);
        }];
        
//        [blackbackgroundView addSubview:self.yuanbaoLabel];
//        [self.yuanbaoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.left.mas_equalTo(10);
//            make.top.mas_equalTo(UIScale(12));
//        }];
        
        [blackbackgroundView addSubview:self.scoreLabel];
        [self.scoreLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(10);
            make.centerY.mas_equalTo(0);
        }];
        
        
        
        [blackbackgroundView addSubview:self.sendButton];
        [self.sendButton mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.right.mas_equalTo(-10);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(UIScale(64));
            make.height.mas_equalTo(UIScale(25));
        }];
        
//        [blackbackgroundView addSubview:self.rechargeButton];
//        [self.rechargeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//            
//            make.right.mas_equalTo(self.sendButton.mas_left).mas_offset(UIScale(-12));
//            make.centerY.mas_equalTo(0);
//            make.width.mas_equalTo(UIScale(50));
//            make.height.mas_equalTo(UIScale(17));
//        }];

        
    }
    return self;
}

- (void) setScoreYuanbao:(NSDictionary *) dic
{
    self.yuanbaoLabel.text = [NSString stringWithFormat:@"金元宝:%@",ToNumber([dic objectForKey:@"gold"])];
    self.scoreLabel.text = [NSString stringWithFormat:@"积分:%@",ToNumber([dic objectForKey:@"score"])];
    
}
//显示视图
- (void) showInView:(UIView *) view
{
    
    [view addSubview:self];
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = self.backgroundView.frame;
        frame.origin.y = self.frame.size.height - self.backgroundView.frame.size.height;
        self.backgroundView.frame = frame;
        
    }];
}

//隐藏视图
- (void) hiddenView
{
    [UIView animateWithDuration:0.25 animations:^{
        
        CGRect frame = self.backgroundView.frame;
        frame.origin.y = self.frame.size.height;
        self.backgroundView.frame = frame;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        
    }];
}
- (void) sendButtonClicked:(UIButton *) button
{
    if (!oldGiftModel) {//如果当前未选中礼物，则直接返回
        return;
    }
    if (_block) {
        _block(button,oldGiftModel);
    }
}
- (void) refreshGiftView
{
    [self.collectionView reloadData];
}
#pragma mark-------------控件初始化-------------------------

- (UILabel *) yuanbaoLabel
{
    if (!_yuanbaoLabel) {
        
        _yuanbaoLabel = [[UILabel alloc] init];
        _yuanbaoLabel.font = FONT(12);
        _yuanbaoLabel.textAlignment = NSTextAlignmentLeft;
        _yuanbaoLabel.textColor = UIColorFromRGB(0xfaf642);
        _yuanbaoLabel.numberOfLines = 0;
        _yuanbaoLabel.text = @"金元宝：0";
    }
    return _yuanbaoLabel;
}

- (UILabel *) scoreLabel
{
    if (!_scoreLabel) {
        
        _scoreLabel = [[UILabel alloc] init];
        _scoreLabel.font = FONT(12);
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        _scoreLabel.textColor = UIColorFromRGB(0xfaf642);
        _scoreLabel.numberOfLines = 0;
        _scoreLabel.text = @"积分：0";
        
    }
    return _scoreLabel;
}

- (UIButton *) sendButton
{
    if(!_sendButton){
        _sendButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _sendButton.tag = 0;
        _sendButton.backgroundColor = UIColorFromRGB(0xeb413e);
        _sendButton.layer.cornerRadius = UIScale(12.5);
        _sendButton.layer.masksToBounds = YES;
        [_sendButton setTitle:@"发送" forState:UIControlStateNormal];
        _sendButton.titleLabel.font = FONT(16);
        [_sendButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_sendButton addTarget:self action:@selector(sendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _sendButton;
}
- (UIButton *) rechargeButton
{
    if(!_rechargeButton){
        _rechargeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _rechargeButton.tag = 1;
        [_rechargeButton setTitle:@"充值" forState:UIControlStateNormal];
        _rechargeButton.titleLabel.font = FONT(16);
        [_rechargeButton setTitleColor:UIColorFromRGB(0xeb413e) forState:UIControlStateNormal];
       
        [_rechargeButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [_rechargeButton addTarget:self action:@selector(sendButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rechargeButton;
}

//设置collectionView
- (UICollectionView *) collectionView
{
    if (!_collectionView) {
        
        LSCollectionViewFlowLayout * flowLayout = [[LSCollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        flowLayout.itemCountPerRow = 4;
        flowLayout.rowCount = 2;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, (self.frame.size.width - 3)/4.0 * 2 + 1 + 20) collectionViewLayout:flowLayout];
        _collectionView.delegate = self;
        _collectionView.pagingEnabled = YES;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.allowsMultipleSelection = YES;
        //注册cell 、SectionHeader、 SectionFooter实现重用
        [_collectionView registerClass:[LSGiftCollectionViewCell class] forCellWithReuseIdentifier:cellID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID];
        
    }
    
    return _collectionView;
}
#pragma UICollectionViewDataSource 提供数据

//返回组数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//返回每组cell的数目
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return self.collectionViewDataSource.count;
    
}

// 根据重用机制返回cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LSGiftCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    [cell setCellData:self.collectionViewDataSource[indexPath.row]];
    //    cell.contentView.backgroundColor = [UIColor greenColor];
    return cell;
}



// 返回每组的页眉和页脚
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView * reusable ;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        reusable = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:headerID forIndexPath:indexPath];
        reusable.backgroundColor = [UIColor cyanColor];
    }
    else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        reusable = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:footerID forIndexPath:indexPath];
        reusable.backgroundColor = [UIColor blackColor];
    }
    return reusable;
}


#pragma UICollectionViewDelegate 特效

//返回YES 表示支持高亮、点击事件
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

// 点击高亮
- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//选中某一项,在这里可实现跳转
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击%ld",(long)indexPath.row);
    LSGiftCollectionViewCellModel * cellModel = self.collectionViewDataSource[indexPath.row];
    if (cellModel == oldGiftModel) {
        return;
    }
    if (oldGiftModel) {
        oldGiftModel.giftSelectedState = NO;
    }
   
    cellModel.giftSelectedState = YES;
    oldGiftModel = cellModel;
    [collectionView reloadData];
}

#pragma UICollectionViewDelegateFlowLayout  空间布局

//返回每一项的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return (CGSize){(collectionView.frame.size.width-3)/4.0,(collectionView.frame.size.width-3)/4.0 + 10};
}
//返回cell距section的间隔
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

//每组cell的行间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}
//每组cell的列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 1.0f;
}

//设置每组页眉（头视图）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
{
    return (CGSize){0,0};
}
//设置每组页脚（尾视图）的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section;
{
    return (CGSize){0,0};
}
- (void) touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
    UITouch * touch = [touches anyObject];
    CGPoint point = [touch locationInView:self];
    if (point.y < self.frame.size.height - 225) {
        [self hiddenView];//隐藏视图
    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
