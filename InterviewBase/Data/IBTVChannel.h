//
//  IBTVChannel.h
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface IBTVChannel : JSONModel

@property (nonatomic) NSInteger channelId;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSArray *program;

- (NSDate *)getMinimumDate;
- (NSDate *)getMaximumDate;

@end
