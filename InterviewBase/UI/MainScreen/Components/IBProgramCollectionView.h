//
//  IBProgramCollectionView.h
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBProgramCollectionView : UIView<UICollectionViewDelegate, UICollectionViewDataSource>
{
    UICollectionView *columnTitlesCollectionView;
    UICollectionView *rowTitlesCollectionView;
    UICollectionView *dataCollectionView;
    
    NSArray *columnTitles;
    NSArray *rowTitles;
    NSArray *dataArray;
}

//@property (nonatomic, weak) id<TableViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame columnTitles:(NSArray *)_columnTitles rowTitles:(NSArray *)_rowTitles dataArray:(NSArray *)_dataArray;
- (void)setNow;
@end
