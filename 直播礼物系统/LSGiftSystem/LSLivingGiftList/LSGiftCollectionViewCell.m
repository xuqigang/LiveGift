//
//  LSGiftCollectionViewCell.m
//  hong5
//
//  Created by 郭敬楠 on 17/4/19.
//  Copyright © 2017年 com.hong5.ios. All rights reserved.
//

#import "LSGiftCollectionViewCell.h"

@implementation LSGiftCollectionViewCell
- (instancetype) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
       
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.6];
        
        [self.contentView addSubview:self.textLabel];
        [self.textLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.contentView.mas_bottom).mas_offset(UIScale(-30));
            
        }];
        
        [self.contentView addSubview:self.giftImageView];
        [self.giftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.top.right.mas_equalTo(0);
            make.bottom.mas_equalTo(self.textLabel.mas_top).mas_offset(UIScale(-4));
        }];
        
        [self.contentView addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.top.mas_equalTo(5);
            make.right.mas_equalTo(-5);
            make.width.height.mas_equalTo(UIScale(15));
        }];
    
        
              
        
        
    }
    return self;
}

- (UIImageView *) giftImageView
{
    if (!_giftImageView) {
        
        _giftImageView = [[UIImageView alloc] init];
        _giftImageView.image = [UIImage imageNamed:@""];
        _giftImageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    return _giftImageView;
}

- (UILabel *) textLabel
{
    if (!_textLabel) {
        _textLabel = [[UILabel alloc] init];
        _textLabel.textColor = UIColorFromRGB(0xe0e0e0);
        _textLabel.font = FONT(14);
        _textLabel.textAlignment = NSTextAlignmentCenter;
        _textLabel.numberOfLines = 0;
        _textLabel.text = @"";
        
    }
    return _textLabel;
}
- (UIButton *) button
{
    if(!_button){
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.tag = 0;
        [_button setImage:[UIImage new] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"xz"] forState:UIControlStateSelected];
    
    }
    return _button;
}


- (void) setCellData:(LSGiftCollectionViewCellModel *) cellData
{
   
    
    self.button.selected = NO;
    self.giftImageView.image = nil;
    self.textLabel.attributedText = nil;
    
    //设置礼物选中状态
    self.button.selected = cellData.giftSelectedState;
    
    NSLog(@"selected = %d",self.button.selected);
    NSURL * url = [NSURL URLWithString:ToString(cellData.url)];
//    [self.giftImageView sd_setImageWithURL:url];
    
    NSString * type = ToString(cellData.category);
    if ([type isEqualToString:@"FREE"]) {
        _textLabel.text = @"免费";
    }
    else if([type isEqualToString:@"SCORE"]){
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分",cellData.score]];
//        [str addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xeb413e) range:NSMakeRange(0, str.length - 2)];
//        [str addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xe0e0e0) range:NSMakeRange(str.length - 2, 2)];
        _textLabel.attributedText = str;
    }
    else if([type isEqualToString:@"GOLD"]){
        NSMutableAttributedString * str = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@金元宝",ToString(cellData.gold)]];
//        [str addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xeb413e) range:NSMakeRange(0, str.length - 3)];
//        [str addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xe0e0e0) range:NSMakeRange(str.length - 3, 3)];
        _textLabel.attributedText = str;
    }
    else if([type isEqualToString:@"S_G"]){
        NSMutableAttributedString * str1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@积分\n",ToNumber(cellData.score)]];
//        [str1 addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xeb413e) range:NSMakeRange(0, str1.length - 3)];
//        [str1 addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xe0e0e0) range:NSMakeRange(str1.length - 3, 3)];
        
        NSMutableAttributedString * str2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@金元宝",ToString(cellData.gold)]];
//        [str2 addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xeb413e) range:NSMakeRange(0, str2.length - 3)];
//        [str2 addFont:FONT(14) ForegroundColor:UIColorFromRGB(0xe0e0e0) range:NSMakeRange(str2.length - 3, 3)];
        
        [str1 appendAttributedString:str2];
        _textLabel.attributedText = str1;
    }

}
/**
 * 免费礼物 FREE,
 */

/**
 * 积分礼物 SCORE,
 */

/**
 * 金元宝礼物 GLOD,
 */

/**
 * 积分或金元宝S_G;
 */

- (void) checkGiftType:(NSString *) type
{
    }

@end


