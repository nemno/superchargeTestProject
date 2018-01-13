//
//  IBProgramme.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBProgramme.h"

@implementation IBProgramme

- (instancetype)initWithDictionary:(NSDictionary *)dict error:(NSError *__autoreleasing *)err {
    self = [super initWithDictionary:dict error:err];
    
    if (self) {
        if ([dict objectForKey:@"start_date"] && [[dict objectForKey:@"start_date"] isKindOfClass:[NSString class]]) {
            self.startDate = [NSDateFormatter dateFromString:[dict objectForKey:@"start_date"] forDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        }
        
        if ([dict objectForKey:@"end_date"] && [[dict objectForKey:@"end_date"] isKindOfClass:[NSString class]]) {
            self.endDate = [NSDateFormatter dateFromString:[dict objectForKey:@"end_date"] forDateFormat:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
        }
    }
    
    return self;
}

+ (JSONKeyMapper *)keyMapper {
    return [[JSONKeyMapper alloc] initWithModelToJSONDictionary:@{ @"startDate" : @"start_date",
                                                                   @"endDate" : @"end_date"
                                                                   }];
}

- (NSTimeInterval)getPlaytimeInSeconds {
    if (self.startDate && self.endDate) {
        return [self.endDate timeIntervalSinceDate:self.startDate];
    }
    
    return 0;
}

@end
