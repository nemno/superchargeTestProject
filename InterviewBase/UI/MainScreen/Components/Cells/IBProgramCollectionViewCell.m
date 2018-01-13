//
//  IBProgramCollectionViewCell.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBProgramCollectionViewCell.h"

@implementation IBProgramCollectionViewCell
@synthesize program;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:70.0f / 255.0f green:73.0f / 255.0f blue:85.0f / 255.0f alpha:1.0f];
        
        startTimeLabel = [[UILabel alloc] initWithFrame:self.bounds];
        startTimeLabel.textAlignment = NSTextAlignmentLeft;
        startTimeLabel.backgroundColor = [UIColor clearColor];
        startTimeLabel.font = [UIFont systemFontOfSize:11.0f weight:UIFontWeightLight];
        startTimeLabel.textColor = [UIColor colorWithWhite:255.0f / 255.0f alpha:0.5f];
        [self.contentView addSubview:startTimeLabel];
        
        titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0f weight:UIFontWeightRegular];
        titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    startTimeLabel.frame = CGRectMake(5.0f, 0.0f, self.frame.size.width - 10.0f, 18);
    titleLabel.frame = CGRectMake(5.0f, CGRectGetMaxY(startTimeLabel.frame), self.frame.size.width - 10.0f, self.frame.size.height - 18.0f);
}

- (void)setProgram:(IBProgramme *)_program {
    program = _program;
    titleLabel.text = program.title;
    startTimeLabel.text = [NSDateFormatter stringFromDate:program.startDate forDateFormat:@"HH:mm"];
}
@end
