//
//  IBProgramTitleCollectionViewCell.h
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBProgramTitleCollectionViewCell : UICollectionViewCell{
    UILabel *titleLabel;
}

@property (nonatomic, strong) NSString *title;

@end
