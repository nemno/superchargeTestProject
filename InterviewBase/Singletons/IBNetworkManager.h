//
//  IBNetworkManager.h
//  InterViewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNetworkManager [IBNetworkManager getInstance]

typedef void (^AsyncNetworkSuccessCallback)(NSObject *data, NSError *error);

@interface IBNetworkManager : NSObject

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (IBNetworkManager *)getInstance;
- (void)sendRequestWithParameters:(NSDictionary *)params withURLTail:(NSString *)urlTail completion:(AsyncNetworkSuccessCallback)completion;

@end
