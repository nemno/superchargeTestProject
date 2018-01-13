//
//  IBProgramCollectionViewCell.h
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBProgramme.h"

@interface IBProgramCollectionViewCell : UICollectionViewCell {
    UILabel *startTimeLabel;
    UILabel *titleLabel;
    
}

@property (nonatomic, strong) IBProgramme *program;

@end
