//
//  UserInfo.m
//  FlashPayBo
//
//  Created by FanXing on 2017/12/23.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo


- (void)encodeWithCoder:(NSCoder *)aCoder{
    
//    [aCoder encodeObject:self.avatar forKey:@"avatar"];
//
//    [aCoder encodeObject:self.auth_status forKey:@"auth_status"];
//
//    [aCoder encodeObject:self.bank_account forKey:@"bank_account"];
//
//    [aCoder encodeObject:self.bank_area forKey:@"bank_area"];
//
//    [aCoder encodeObject:self.bank_name forKey:@"bank_name"];
//
//    [aCoder encodeObject:self.bank_name_type forKey:@"bank_name_type"];
//
//    [aCoder encodeObject:self.level forKey:@"level"];
    
    [aCoder encodeObject:self.phone forKey:@"phone"];
    
//    [aCoder encodeObject:self.realname forKey:@"realname"];
//
//    [aCoder encodeObject:self.sfz forKey:@"sfz"];
    
    [aCoder encodeObject:self.user_id forKey:@"user_id"];
    
    
    
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super init];
    
    if (self) {
        
//        self.avatar = [aDecoder decodeObjectForKey:@"avatar"];
//
//        self.auth_status = [aDecoder decodeObjectForKey:@"auth_status"];
//
//        self.bank_account = [aDecoder decodeObjectForKey:@"bank_account"];
//
//        self.bank_area = [aDecoder decodeObjectForKey:@"bank_area"];
//
//        self.bank_name = [aDecoder decodeObjectForKey:@"bank_name"];
//
//        self.bank_name_type = [aDecoder decodeObjectForKey:@"bank_name_type"];
//
//        self.level = [aDecoder decodeObjectForKey:@"level"];
        
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        
//        self.realname = [aDecoder decodeObjectForKey:@"realname"];
//
//        self.sfz = [aDecoder decodeObjectForKey:@"sfz"];
        
        self.user_id = [aDecoder decodeObjectForKey:@"user_id"];
        
        
    }
    
    return self;
    
}
@end
