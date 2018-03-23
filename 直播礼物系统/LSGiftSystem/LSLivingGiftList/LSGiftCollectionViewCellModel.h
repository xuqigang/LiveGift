//
//  LSGiftCollectionViewCellModel.h
//  ObjectToDictionary
//
//  Created by ma c on 15/9/19.
//  Copyright (c) 2015年 xuqigang. All rights reserved.
//
#import <Foundation/Foundation.h>
@interface LSGiftCollectionViewCellModel : NSObject <NSCoding>
@property (nonatomic, assign) BOOL giftSelectedState;//礼物是否被选中
@property (nonatomic, strong) NSString * category;
@property (nonatomic, strong) NSString * pk;
@property (nonatomic, strong) NSString * createdDate;
@property (nonatomic, strong) NSString * score;
@property (nonatomic, strong) NSString * measure;
@property (nonatomic, strong) NSString * gold;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSString * useFlag;
@property (nonatomic, strong) NSString * createdBy;
@property (nonatomic, strong) NSString * fileType;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * isLarge;
@property (nonatomic, strong) NSString * largeUrl;
- (instancetype) initWithDictionary:(NSDictionary *) dicData;

- (void) print;

@end
