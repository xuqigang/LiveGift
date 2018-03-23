//
//  LSLivingGiftShowLayerView.m
//  直播礼物系统
//
//  Created by Hanxiaojie on 2017/7/13.
//  Copyright © 2017年 徐其岗. All rights reserved.
//

#import "LSLivingGiftShowLayerView.h"
#import "PresentView.h"
#import "GiftModel.h"
#import "AnimOperation.h"
#import "AnimOperationManager.h"
@implementation LSLivingGiftShowLayerView

- (void) addGigtData:(NSDictionary *) giftData
{
 
//    NSLog(@"1=%@",[ToString([giftData objectForKey:@"gift_url"]) lastPathComponent]);
//    NSString * senderChatID = [NSString stringWithFormat:@"%@%@",[giftData objectForKey:@"huserPK"],[ToString([giftData objectForKey:@"gift_url"]) lastPathComponent]];
//    
//    NSLog(@"-----------senderChatID = %@",senderChatID);
//    
//    senderChatID = [[senderChatID componentsSeparatedByCharactersInSet:[[NSCharacterSet characterSetWithCharactersInString:@"0123456789"] invertedSet]] componentsJoinedByString:@""];
//    
//    NSLog(@"-----------senderChatID = %@",senderChatID);
    
    // IM 消息
//    GSPChatMessage *msg = [[GSPChatMessage alloc] init];
//    msg.text = [NSString stringWithFormat:@"%@%@",[giftData objectForKey:@"measure"],[giftData objectForKey:@"text"]];
//    msg.senderChatID = @"002";
////    msg.senderChatID = [NSString stringWithFormat:@"%@%@",[giftData objectForKey:@"huserPK"],[giftData objectForKey:@"gift_url"]];
//    msg.senderName = @"XXX";
//    NSLog(@"id %@ -------送了1个【鲜花】--------",msg.senderChatID);
    
    // 礼物模型
    GiftModel *giftModel = [[GiftModel alloc] init];
    giftModel.headImage = @"";
    giftModel.name = [giftData objectForKey:@"personName"];
    giftModel.giftImage = [giftData objectForKey:@"gift_id"];
    giftModel.giftName = [giftData objectForKey:@"giftName"];
    giftModel.giftCount = 1;
    giftModel.userId = [NSString stringWithFormat:@"%@%@",[giftData objectForKey:@"person_id"],[giftData objectForKey:@"gift_id"]];
    
    
    
    AnimOperationManager *manager = [AnimOperationManager sharedManager];
    manager.parentView = self;
    // 用用户唯一标识 msg.senderChatID 存礼物信息,model 传入礼物模型
    [manager animWithUserID:[giftData objectForKey:@"person_id"] model:giftModel finishedBlock:^(BOOL result) {
        
        
        
    }];

    
}
@end
