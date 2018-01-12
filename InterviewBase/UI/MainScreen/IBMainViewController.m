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
    
    self.view.backgroundColor = [UIColor whiteColor];

}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [kContentManager getTVProgramWithCompletion:^(NSObject *data, NSError *error) {
        if (data && !error) {
            if (collectionView) {
                [collectionView removeFromSuperview];
                collectionView = nil;
            }

            collectionView = [[IBProgramCollectionView alloc] initWithFrame:self.view.frame columnTitles:[self generateTitleArray] rowTitles:[self generateRowTitleArray] dataArray:[self generateDataArray]];
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
    for (NSInteger i = 0; i < 24; i++) {
        [tempArray addObject:[NSString stringWithFormat:@"%2ld:00", (long)i]];
        [tempArray addObject:[NSString stringWithFormat:@"%2ld:30", (long)i]];
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

- (NSArray *)generateDataArray {
    NSMutableArray *tempArray = [NSMutableArray array];

    NSArray *titlesArray = [self generateTitleArray];
    
    for (IBTVChannel *channel in kContentManager.channels) {
        NSMutableArray *tempDataArray = [NSMutableArray new];
        
        for (NSString *columnTitle in titlesArray) {
            NSNumber *dummyData = @1;
            [tempDataArray addObject:dummyData];
        }
        [tempArray addObject:tempDataArray];
    }
    
    return tempArray;
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
