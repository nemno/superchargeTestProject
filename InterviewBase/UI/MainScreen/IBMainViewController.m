//
//  IBMainViewController.m
//  InterviewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import "IBMainViewController.h"
#import "IBTVChannel.h"

@interface IBMainViewController ()

@end

@implementation IBMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor redColor];
    self.view.autoresizesSubviews = YES;

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [kContentManager getTVProgramWithCompletion:^(NSObject *data, NSError *error) {
        if (data && !error) {
            if (collectionView) {
                [collectionView removeFromSuperview];
                collectionView = nil;
            }

            collectionView = [[IBProgramCollectionView alloc] initWithFrame:self.view.frame columnTitles:[self generateTitleArray] rowTitles:[self generateRowTitleArray] dataArray:kContentManager.channels];
            collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [collectionView setNow];
            [self.view addSubview:collectionView];
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Helper methods

- (NSArray *)generateTitleArray {
    NSMutableArray *tempArray = [NSMutableArray array];
    
    NSString *minimumMinuteString = [NSDateFormatter stringFromDate:kContentManager.minimumDate forDateFormat:@"mm"];
    NSString *minimumHourString = [NSDateFormatter stringFromDate:kContentManager.minimumDate forDateFormat:@"hh"];
    
    NSDate *iteratingDate = kContentManager.minimumDate;

    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier: NSCalendarIdentifierGregorian];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:iteratingDate];
    [components setMinute:30];
    
    if ([minimumMinuteString integerValue] >= 30) {
        [tempArray addObject:[NSString stringWithFormat:@"%@:30", minimumHourString]];
        iteratingDate = [calendar dateFromComponents:components];
    }
    
    while ([iteratingDate compare:kContentManager.maximumDate] == NSOrderedAscending) {
        [tempArray addObject:[NSDateFormatter stringFromDate:iteratingDate forDateFormat:@"HH:mm"]];
        iteratingDate = [iteratingDate dateByAddingTimeInterval:30.0f * 60.0f];
    }

    return [NSArray arrayWithArray:tempArray];
}

- (NSArray *)generateRowTitleArray {
    NSMutableArray *tempArray = [NSMutableArray array];
    for (IBTVChannel *channel in kContentManager.channels) {
        [tempArray addObject:channel.title];
    }
    return [NSArray arrayWithArray:tempArray];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
