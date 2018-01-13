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
#import "IBTVChannel.h"
#import "IBProgramme.h"

#define timeWidthUnit (200.0f / (30.0f * 60.0f))

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
        
        verticalSeparatorView = [[UIView alloc] init];
        verticalSeparatorView.backgroundColor = [UIColor blueColor];
        
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

- (void)setNow {
    //JUST FOR TESTING DUMMY
//    NSDate *date = [NSDateFormatter dateFromString:@"2017-01-15-23:50:00" forDateFormat:@"yyyy-MM-dd-HH:mm:ss"];
    
    if ([NOW compare:kContentManager.minimumDate] == NSOrderedDescending && [NOW compare:kContentManager.maximumDate] == NSOrderedAscending) {
        UIView *nowLineView = [UIView new];
        nowLineView.backgroundColor = [UIColor whiteColor];
        nowLineView.frame = CGRectMake(timeWidthUnit * [NOW timeIntervalSinceDate:kContentManager.minimumDate], 0.0f, 2.0f, CGRectGetHeight(dataCollectionView.frame));
        nowLineView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [dataCollectionView addSubview:nowLineView];
    }
}

#pragma mark - UICollectionViewDelegate methods

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    if (collectionView == columnTitlesCollectionView) {
        return 1;
    } else if (collectionView == rowTitlesCollectionView) {
        return rowTitles.count;
    } else {
        return dataArray.count;
    }
    
    return 0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    if (collectionView == rowTitlesCollectionView) {
        return 1;
    } else if (collectionView == columnTitlesCollectionView) {
        return columnTitles.count;
    } else {
        return ((IBTVChannel*)[dataArray objectAtIndex:section]).program.count;
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
        cell.program = [((IBTVChannel *)[dataArray objectAtIndex:indexPath.section]).program objectAtIndex:indexPath.row];
        return cell;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (collectionView == rowTitlesCollectionView) {
        CGFloat cellWidth = 120.0f;
        CGFloat cellHeight = MIN(80.0f, ((CGRectGetHeight(dataCollectionView.frame) - 1.0f) / rowTitles.count));
        return CGSizeMake(cellWidth,cellHeight);
    } else if (collectionView == columnTitlesCollectionView) {
        CGFloat cellWidth = 200.0f;
        CGFloat cellHeight = 44.0f;
        return CGSizeMake(cellWidth, cellHeight);
    } else {
        IBProgramme *program = [((IBTVChannel*)[dataArray objectAtIndex:indexPath.section]).program objectAtIndex:indexPath.row];
        CGFloat cellWidth = timeWidthUnit * [program getPlaytimeInSeconds];
        CGFloat cellHeight = MIN(80.0f, ((CGRectGetHeight(dataCollectionView.frame) - 1.0f) / rowTitles.count));
        return CGSizeMake(cellWidth, cellHeight);
    }
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0f;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 2.0f;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    if (collectionView == dataCollectionView) {
        if (section < dataArray.count) {
            IBTVChannel *channel = [dataArray objectAtIndex:section];
            return UIEdgeInsetsMake(0.0f, timeWidthUnit * [kContentManager delayForChannelFromMinimumDate:channel], 0.0f, 0.0f);
        }
    }
    
    return UIEdgeInsetsZero;
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
