//
//  FXHttpTool.m
//  SuperPocket
//
//  Created by FanXing on 2017/10/26.
//  Copyright © 2017年 FanXing. All rights reserved.
//

#import "FXHttpTool.h"
#import <CommonCrypto/CommonDigest.h>
#import "FXGetUrl.h"

#define kBaseUrl  @"http://api.misery.fanx.xin/"

static AFHTTPSessionManager * mgr;

@implementation FXHttpTool


+(void)getWithURL:(NSString *)url params:(NSDictionary *)params sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure{
    
    NSString * baseUrl =kBaseUrl;
    url = [baseUrl stringByAppendingString:url];
    //    NSString * endUrl = [DYGGetUrl connectUrl:[self encryptSign:params].mutableCopy url:url];
    
    mgr = [AFHTTPSessionManager manager];
    [mgr.requestSerializer
     setValue:@"application/octet-stream"
     forHTTPHeaderField:@"Content-Type"];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [self encryptSign:params]
    [mgr GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            
        }
    }];
    
    
}

+(void)postWithURL:(NSString *)url params:(NSDictionary *)params sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure{
    if (![url containsString:@"http"]) {
        NSString * baseUrl = kBaseUrl;
        url = [baseUrl stringByAppendingString:url];
    }
    mgr = [AFHTTPSessionManager manager];
    //    [mgr.requestSerializer
    //     setValue:@"application/x-www-form-urlencoded"
    //     forHTTPHeaderField:@"Content-Type"];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
//    [self encryptSign:params]
    [mgr POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
            
        }
    }];
}
//params传入的参数字典
+(NSDictionary *)encryptSign:(NSDictionary *)params{
    NSDate *datenow = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    
    NSMutableDictionary *dict =@{@"appid":@"2017081014329854",@"appsecret":@"IOS02bca5a9db076ee14aa841ab60735e74",@"timestamp":timeSp,@"os":@"ios"}.mutableCopy;
    [dict addEntriesFromDictionary:params];
    NSMutableArray *keyArr = [NSMutableArray array];
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString *  _Nonnull key, NSString *  _Nonnull obj, BOOL * _Nonnull stop) {
        [keyArr addObject:key];
    }];
    ///排序
    [keyArr sortUsingSelector:@selector(compare:)];
    NSMutableString *signStr = [NSMutableString string];
    for (NSString *key in keyArr) {
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dict[key]];
        ///拼接sign
        [signStr appendString:str];
    }
    NSMutableDictionary *dict2 = @{@"timestamp":timeSp,@"os":@"ios"}.mutableCopy;
    [dict2 addEntriesFromDictionary:params];
    [dict2 addEntriesFromDictionary:@{@"sign":[self sha1:signStr]}];
    return  dict2.copy;
}

+(NSString *)sha1:(NSString *)input{
    
    NSData *data = [input dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];

    
    CC_SHA1(data.bytes, (unsigned int)data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i=0; i<CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}


#pragma mark ---- 非验签请求
+(void)getWithNormalURL:(NSString *)url params:(NSDictionary *)params sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure {
    mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [mgr POST:url parameters:[self encryptSign:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
            
        }
    }];
}

+(void)postWithNormalURL:(NSString *)url params:(NSDictionary *)params sucess:(void (^)(id))sucess failure:(void (^)(NSError *))failure {
    mgr = [AFHTTPSessionManager manager];
    mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    mgr.responseSerializer = [AFHTTPResponseSerializer serializer];
    [mgr POST:url parameters:[self encryptSign:params] progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (sucess) {
            
            sucess(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if(failure){
            failure(error);
            
        }
    }];
}
@end
