//
//  IBTVChannel.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBTVChannel.h"
#import "IBProgramme.h"

@implementation IBTVChannel

- (instancetype)initWithDictionary:(NSDictionary *)objectDictionary error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:objectDictionary error:err];
    
    if (self) {
        if ([objectDictionary objectForKey:@"programme"] && [[objectDictionary objectForKey:@"programme"] isKindOfClass:[NSArray class]]) {
            NSMutableArray *tempArray = [NSMutableArray array];
            
            for (NSDictionary *programDictionary in [objectDictionary objectForKey:@"programme"]) {
                NSError *jsonError;
                IBProgramme *program = [[IBProgramme alloc] initWithDictionary:programDictionary error:&jsonError];
                [tempArray addObject:program];
            }
            
            self.program = [NSArray arrayWithArray:tempArray];
        }
    }
    
    return self;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{
                                                                  @"channelId" : @"id",
                                                                  @"program" : @"programme"
                                                                  }];
}

- (NSDate *)getMinimumDate {
    NSDate *minimumDate = nil;
    for (IBProgramme *tempProgram in self.program) {
        if (minimumDate) {
            if ([minimumDate compare:tempProgram.startDate] == NSOrderedDescending) {
                minimumDate = tempProgram.startDate;
            }
        } else {
            minimumDate = tempProgram.startDate;
        }
    }
    return minimumDate;
}

- (NSDate *)getMaximumDate {
    NSDate *maximumDate = nil;
    for (IBProgramme *tempProgram in self.program) {
        if (maximumDate) {
            if ([maximumDate compare:tempProgram.endDate] == NSOrderedAscending) {
                maximumDate = tempProgram.endDate;
            }
        } else {
            maximumDate = tempProgram.startDate;
        }
    }
    return maximumDate;
}

@end
