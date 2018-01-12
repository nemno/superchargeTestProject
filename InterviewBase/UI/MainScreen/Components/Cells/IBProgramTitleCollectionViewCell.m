//
//  IBProgramTitleCollectionViewCell.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBProgramTitleCollectionViewCell.h"

@implementation IBProgramTitleCollectionViewCell
@synthesize title;

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor blueColor];
        titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textColor = [UIColor whiteColor];
        [self.contentView addSubview:titleLabel];
    }
    
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    titleLabel.frame = CGRectMake(5.0f, 0.0f, self.frame.size.width - 10.0f, self.frame.size.height);
}

- (void)setTitle:(NSString *)_title {
    title = _title;
    titleLabel.text = title;
}

@end
