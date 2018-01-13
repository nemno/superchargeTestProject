//
//  IBContentManager.h
//  InterViewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IBTVChannel.h"

#define kContentManager [IBContentManager getInstance]

@interface IBContentManager : NSObject

@property (nonatomic, strong) NSArray *channels;
@property (nonatomic, strong) NSDate *minimumDate;
@property (nonatomic, strong) NSDate *maximumDate;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (IBContentManager *)getInstance;

- (void)getTVProgramWithCompletion:(AsyncNetworkSuccessCallback)completion;
- (NSTimeInterval)delayForChannelFromMinimumDate:(IBTVChannel *)channel;
@end
