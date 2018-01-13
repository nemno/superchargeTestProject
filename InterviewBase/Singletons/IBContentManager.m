//
//  IBContentManager.m
//  InterViewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import "IBContentManager.h"

@implementation IBContentManager
@synthesize channels;

+ (IBContentManager *)getInstance {
    static dispatch_once_t pred;
    __strong static id sharedInstance = nil;
    dispatch_once( &pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)getTVProgramWithCompletion:(AsyncNetworkSuccessCallback)completion {
    if (self.channels) {
        return completion(self.channels, nil);
    } else {
        [kNetworkManager sendRequestWithParameters:nil withURLTail:@"/ad856e7994b8ea93ac27503ecb051347/raw/050c539749f3d253a01ad685983ebc8503ea7872/example.json" completion:^(NSObject *data, NSError *error) {
            if (data && !error) {
                if ([data isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *responseDictionary = (NSDictionary *)data;
                    
                    if ([responseDictionary objectForKey:@"channels"] && [[responseDictionary objectForKey:@"channels"] isKindOfClass:[NSArray class]]) {
                        NSMutableArray *tempChannelsArray = [NSMutableArray array];
                        for (NSDictionary *channelDictionary in (NSArray *)[responseDictionary objectForKey:@"channels"]) {
                            NSError *jsonError;
                            IBTVChannel *channel = [[IBTVChannel alloc] initWithDictionary:channelDictionary error:&jsonError];
                            [tempChannelsArray addObject:channel];
                        }
                        self.channels = [NSArray arrayWithArray:tempChannelsArray];
                        
                        [self calculateMinimumDate];
                        [self calculateMaximumDate];
                        
                        return completion(self.channels, nil);
                    }
                }
            }
            
            //Something went wrong
            return completion(data, error);
        }];
    }
}

- (void)calculateMinimumDate {
    NSDate *minDate = nil;
    for (IBTVChannel *channel in self.channels) {
        NSDate *channelMinimumDate = [channel getMinimumDate];

        if (minDate) {
            if ([minDate compare:channelMinimumDate] == NSOrderedDescending) {
                minDate = channelMinimumDate;
            }
        } else {
            minDate = channelMinimumDate;
        }
    }
    
    self.minimumDate = minDate;
}

- (void)calculateMaximumDate {
    NSDate *maxDate = nil;
    for (IBTVChannel *channel in self.channels) {
        NSDate *channelMaximumDate = [channel getMaximumDate];
        
        if (maxDate) {
            if ([maxDate compare:channelMaximumDate] == NSOrderedAscending) {
                maxDate = channelMaximumDate;
            }
        } else {
            maxDate = channelMaximumDate;
        }
    }
    
    self.maximumDate = maxDate;
}

- (NSTimeInterval)delayForChannelFromMinimumDate:(IBTVChannel *)channel {
    if (self.minimumDate) {
        return [[channel getMinimumDate] timeIntervalSinceDate:self.minimumDate];
    }
    
    return 0;
}

@end
