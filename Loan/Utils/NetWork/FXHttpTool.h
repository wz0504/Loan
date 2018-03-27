//
//  FXHttpTool.h
//  SuperPocket
//
//  Created by FanXing on 2017/10/26.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface FXHttpTool : AFHTTPSessionManager

//get 请求
+(void)getWithURL:(NSString *)url params:(NSDictionary *)params sucess:(void(^)(id json))sucess failure:(void(^)(NSError * error))failure;


//post请求

+(void)postWithURL:(NSString *)url params:(NSDictionary *)params sucess:(void(^)(id json))sucess failure:(void(^)(NSError * error))failure;

@property(nonatomic,copy)NSString * endUrl;

+(NSDictionary *)encryptSign:(NSDictionary *)params;



//get 请求
+(void)getWithNormalURL:(NSString *)url params:(NSDictionary *)params sucess:(void(^)(id json))sucess failure:(void(^)(NSError * error))failure;


//post请求

+(void)postWithNormalURL:(NSString *)url params:(NSDictionary *)params sucess:(void(^)(id json))sucess failure:(void(^)(NSError * error))failure;
@end
