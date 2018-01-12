//
//  IBProgramCollectionViewCell.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBProgramCollectionViewCell.h"

@implementation IBProgramCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:70.0f / 255.0f green:73.0f / 255.0f blue:85.0f / 255.0f alpha:1.0f];
        valueLabel = [[UILabel alloc] initWithFrame:self.bounds];
        valueLabel.textAlignment = NSTextAlignmentCenter;
        valueLabel.backgroundColor = [UIColor clearColor];
        valueLabel.font = [UIFont fontWithName:@"DINAlternate-Bold" size:18.0f];//[UIFont fontWithName:@"BebasNeue-Bold" size:18.0f];//[UIFont fontWithName:@"BebasNeue-Bold" size:18.0f];
        valueLabel.textColor = [UIColor blackColor];
        [self.contentView addSubview:valueLabel];
    }
    
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    valueLabel.frame = CGRectMake(5.0f, 0.0f, self.frame.size.width-10.0f, self.frame.size.height);
}
@end
