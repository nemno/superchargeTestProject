//
//  IBNetworkManager.m
//  InterViewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import "IBNetworkManager.h"
#import <AFNetworking/AFNetworking.h>

@implementation IBNetworkManager

+ (IBNetworkManager *)getInstance {
    static dispatch_once_t pred;
    __strong static id sharedInstance = nil;
    dispatch_once( &pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)sendRequestWithParameters:(NSDictionary *)params withURLTail:(NSString *)urlTail completion:(AsyncNetworkSuccessCallback)completion {
    [kNavigationManager showLoadingIndicator:YES];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];

    [manager GET:[NSString stringWithFormat:@"%@%@", kBaseURL, urlTail] parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {

    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [kNavigationManager showLoadingIndicator:NO];
        return completion([self cleanJsonToObject:responseObject], nil);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [kNavigationManager showLoadingIndicator:NO];
        return completion(nil, error);
    }];
}

- (id)cleanJsonToObject:(id)data {
    NSError *error;
    
    if (data == (id)[NSNull null]){
        return [[NSObject alloc] init];
    }
    
    id jsonObject;
    
    if ([data isKindOfClass:[NSData class]]) {
        jsonObject = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    } else {
        jsonObject = data;
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        NSMutableArray *array = [jsonObject mutableCopy];
        for (NSInteger i = array.count - 1; i >= 0; i--) {
            id a = array[i];
            if (a == (id)[NSNull null]){
                [array removeObjectAtIndex:i];
            } else {
                array[i] = [self cleanJsonToObject:a];
            }
        }
        return array;
    } else if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dictionary = [jsonObject mutableCopy];
        for(NSString *key in [dictionary allKeys]) {
            id d = dictionary[key];
            if (d == (id)[NSNull null]){
                dictionary[key] = @"";
            } else {
                dictionary[key] = [self cleanJsonToObject:d];
            }
        }
        return dictionary;
    } else {
        return jsonObject;
    }
}

@end
