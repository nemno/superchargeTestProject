//
//  IBProgramCollectionView.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 12..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBProgramCollectionView.h"
#import "IBProgramCollectionViewLayout.h"
#import "IBProgramTitleCollectionViewCell.h"
#import "IBProgramCollectionViewCell.h"

@implementation IBProgramCollectionView{
    UIView *horizontalSeparatorView;
    UIView *verticalSeparatorView;
}

- (instancetype)initWithFrame:(CGRect)frame columnTitles:(NSArray *)_columnTitles rowTitles:(NSArray *)_rowTitles dataArray:(NSArray *)_dataArray {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        
        columnTitles = _columnTitles;
        rowTitles = _rowTitles;
        dataArray = _dataArray;
        
        horizontalSeparatorView = [[UIView alloc] init];
        horizontalSeparatorView.backgroundColor = [UIColor blueColor];
        [self addSubview:horizontalSeparatorView];
        
        verticalSeparatorView = [[UIView alloc] init];
        verticalSeparatorView.backgroundColor = [UIColor blueColor];
        [self addSubview:verticalSeparatorView];
        
        
        columnTitlesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[IBProgramCollectionViewLayout alloc] init]];
        columnTitlesCollectionView.backgroundColor = [UIColor blueColor];
        columnTitlesCollectionView.delegate = self;
        columnTitlesCollectionView.dataSource = self;
        ((UICollectionViewFlowLayout *)columnTitlesCollectionView.collectionViewLayout).scrollDirection = UICollectionViewScrollDirectionHorizontal;
        [columnTitlesCollectionView registerClass:[IBProgramTitleCollectionViewCell class] forCellWithReuseIdentifier:@"columnTitleCell"];
        columnTitlesCollectionView.bounces = YES;
        columnTitlesCollectionView.scrollEnabled = NO;
        columnTitlesCollectionView.allowsMultipleSelection = YES;
        columnTitlesCollectionView.userInteractionEnabled = NO;
        [self addSubview:columnTitlesCollectionView];
        
        
        rowTitlesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[IBProgramCollectionViewLayout alloc] init]];
        rowTitlesCollectionView.collectionViewLayout = [[IBProgramCollectionViewLayout alloc] init];
        rowTitlesCollectionView.backgroundColor = [UIColor blueColor];
        rowTitlesCollectionView.delegate = self;
        rowTitlesCollectionView.dataSource = self;
        rowTitlesCollectionView.bounces = YES;
        rowTitlesCollectionView.scrollEnabled = NO;
        rowTitlesCollectionView.userInteractionEnabled = NO;
        rowTitlesCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [rowTitlesCollectionView registerClass:[IBProgramTitleCollectionViewCell class] forCellWithReuseIdentifier:@"rowTitleCell"];
        [self addSubview:rowTitlesCollectionView];
        
        
        dataCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:[[IBProgramCollectionViewLayout alloc] init]];
        dataCollectionView.collectionViewLayout = [[IBProgramCollectionViewLayout alloc] init];
        dataCollectionView.backgroundColor = [UIColor whiteColor];
        dataCollectionView.delegate = self;
        dataCollectionView.dataSource = self;
        dataCollectionView.bounces = YES;
        dataCollectionView.allowsMultipleSelection = YES;
        dataCollectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [dataCollectionView registerClass:[IBProgramCollectionViewCell class] forCellWithReuseIdentifier:@"dataCell"];
        dataCollectionView.contentSize = CGSizeMake(CGRectGetWidth(dataCollectionView.frame) * 4.0f, CGRectGetHeight(dataCollectionView.frame));
        [self addSubview:dataCollectionView];
        
        CGFloat rowHeaderWidth = 120.0f;
        CGFloat columnHeaderHeight = 44.0f;
        CGFloat separatorLineWidth = 2.0f;
        
        horizontalSeparatorView.frame = CGRectMake(0.0f, columnHeaderHeight, CGRectGetWidth(frame), separatorLineWidth);
        verticalSeparatorView.frame = CGRectMake(rowHeaderWidth, 0.0f, separatorLineWidth, CGRectGetHeight(frame));
        
        CGRect columnHeaderCollectionViewFrame = CGRectMake(CGRectGetMaxX(verticalSeparatorView.frame),
                                                            0.0f,
                                                            CGRectGetWidth(self.frame) - CGRectGetMaxX(verticalSeparatorView.frame),
                                                            CGRectGetMinY(horizontalSeparatorView.frame));
        columnTitlesCollectionView.frame = columnHeaderCollectionViewFrame;
        
        
        CGRect rowHeaderCollectionViewFrame = CGRectMake(0.0f,
                                                         CGRectGetMaxY(horizontalSeparatorView.frame),
                                                         CGRectGetMinX(verticalSeparatorView.frame),
                                                         CGRectGetHeight(self.frame) - CGRectGetMaxY(horizontalSeparatorView.frame));
        rowTitlesCollectionView.frame = rowHeaderCollectionViewFrame;
        
        CGRect dataCollectionViewFrame = CGRectMake(CGRectGetMaxX(verticalSeparatorView.frame), CGRectGetMaxY(horizontalSeparatorView.frame), CGRectGetWidth(columnTitlesCollectionView.frame), CGRectGetHeight(rowTitlesCollectionView.frame));
        dataCollectionView.frame = dataCollectionViewFrame;
    }
    return self;
}

#pragma mark - UICollectionViewDelegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == columnTitlesCollectionView) {
        return 1;
    } else if (collectionView == rowTitlesCollectionView) {
        return rowTitles.count;
    } else {
        return rowTitles.count;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == rowTitlesCollectionView) {
        return 1;
    } else if (collectionView == columnTitlesCollectionView) {
        return columnTitles.count;
    } else {
        return columnTitles.count;
    }
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == columnTitlesCollectionView) {
        IBProgramTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"columnTitleCell" forIndexPath:indexPath];
        cell.title = [columnTitles objectAtIndex:indexPath.row];
        return cell;
    } else if (collectionView == rowTitlesCollectionView) {
        IBProgramTitleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"rowTitleCell" forIndexPath:indexPath];
        cell.title = [rowTitles objectAtIndex:indexPath.section];
        return cell;
    } else {
        IBProgramCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"dataCell" forIndexPath:indexPath];
//        cell.value =[[dataArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)cv layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (cv == rowTitlesCollectionView) {
        CGFloat cellWidth = 120.0f;
        CGFloat cellHeight = MIN(80.0f, ((CGRectGetHeight(dataCollectionView.frame) - 1.0f) / rowTitles.count));
        return CGSizeMake(cellWidth,cellHeight);
    }
    else if (cv == columnTitlesCollectionView) {
        CGFloat cellWidth = MAX(200.0f, MIN(200.0f, ((CGRectGetWidth(dataCollectionView.frame) - 1.0f) / [[dataArray objectAtIndex:indexPath.section] count])));
        CGFloat cellHeight = 44.0f;
        return CGSizeMake(cellWidth, cellHeight);
    }
    else {
        CGFloat cellWidth = MAX(200.0f, MIN(200.0f, (CGRectGetWidth(dataCollectionView.frame) - 1.0f) / [[dataArray objectAtIndex:indexPath.section] count]));
        CGFloat cellHeight = MIN(80.0f, ((CGRectGetHeight(dataCollectionView.frame) - 1.0f) / rowTitles.count));
        return CGSizeMake(cellWidth, cellHeight);
    }
}


- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1.0f;
}

#pragma mark - UIScrollViewDelegate methods

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == dataCollectionView) {
        rowTitlesCollectionView.contentOffset = CGPointMake(0.0f, dataCollectionView.contentOffset.y);
        columnTitlesCollectionView.contentOffset = CGPointMake(dataCollectionView.contentOffset.x, 0.0f);
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
