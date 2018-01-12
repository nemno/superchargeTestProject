//
//  IBProgramme.h
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JSONModel/JSONModel.h>

@interface IBProgramme : JSONModel

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSDate *startDate;
@property (nonatomic, strong) NSDate *endDate;

@end
