//
//  GiftModel.h
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//



#import <UIKit/UIKit.h>

@interface GiftModel : NSObject
@property (nonatomic,strong) NSString *headImage; // 头像
@property (nonatomic,strong) NSString *giftImage; // 礼物
@property (nonatomic,copy) NSString *name; // 送礼物者
@property (nonatomic,copy) NSString *giftName; // 礼物名称
@property (nonatomic,assign) NSInteger giftCount; // 礼物个数
@property (nonatomic, strong) NSString * userId;  //用户ID

@end
