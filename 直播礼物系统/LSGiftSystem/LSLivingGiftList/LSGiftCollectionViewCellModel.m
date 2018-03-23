//
//  LSGiftCollectionViewCellModel.h
//  ObjectToDictionary
//
//  Created by ma c on 15/12/24.
//  Copyright (c) 2015年 xuqigang. All rights reserved.
//
#import "LSGiftCollectionViewCellModel.h"
@implementation LSGiftCollectionViewCellModel


- (instancetype)init
{
    self = [super init];
    if (self) {
        self.giftSelectedState = NO;
        self. category = @"";
        self.createdDate = @"";
        self.score = @"";
        self.measure = @"";
        self.gold = @"";
        self.url = @"";
        self.useFlag = @"";
        self.createdBy = @"";
        self.fileType = @"";
        self.name = @"";
        
    }
    return self;
}
- (instancetype) initWithDictionary:(NSDictionary *) dicData
{
    if(self = [super init])
    {
        [self setValuesForKeysWithDictionary:dicData];
    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_category forKey:@"000"];
    [aCoder encodeObject:_pk forKey:@"001"];
    [aCoder encodeObject:_createdDate forKey:@"002"];
    [aCoder encodeObject:_score forKey:@"003"];
    [aCoder encodeObject:_measure forKey:@"004"];
    [aCoder encodeObject:_gold forKey:@"005"];
    [aCoder encodeObject:_url forKey:@"006"];
    [aCoder encodeObject:_useFlag forKey:@"007"];
    [aCoder encodeObject:_createdBy forKey:@"008"];
    [aCoder encodeObject:_fileType forKey:@"009"];
    [aCoder encodeObject:_name forKey:@"010"];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        _category = [aDecoder decodeObjectForKey:@"000"];
        _pk = [aDecoder decodeObjectForKey:@"001"];
        _createdDate = [aDecoder decodeObjectForKey:@"002"];
        _score = [aDecoder decodeObjectForKey:@"003"];
        _measure = [aDecoder decodeObjectForKey:@"004"];
        _gold = [aDecoder decodeObjectForKey:@"005"];
        _url = [aDecoder decodeObjectForKey:@"006"];
        _useFlag = [aDecoder decodeObjectForKey:@"007"];
        _createdBy = [aDecoder decodeObjectForKey:@"008"];
        _fileType = [aDecoder decodeObjectForKey:@"009"];
        _name = [aDecoder decodeObjectForKey:@"010"];
    }
    return self;
}

- (NSString *) description
{
    return [NSString stringWithFormat:@"%@ %@ %@ %@ %@ %@ %@ %@ %@ %@ %@ ", _category, _pk, _createdDate, _score, _measure, _gold, _url, _useFlag, _createdBy, _fileType, _name ];
}

- (void) print
{
   NSLog(@"category = %@", _category);
   NSLog(@"pk = %@", _pk);
   NSLog(@"createdDate = %@", _createdDate);
   NSLog(@"score = %@", _score);
   NSLog(@"measure = %@", _measure);
   NSLog(@"gold = %@", _gold);
   NSLog(@"url = %@", _url);
   NSLog(@"useFlag = %@", _useFlag);
   NSLog(@"createdBy = %@", _createdBy);
   NSLog(@"fileType = %@", _fileType);
   NSLog(@"name = %@", _name);
}
//字典容错处理，保证用字典初始化对象时不会出错
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{

}

@end
