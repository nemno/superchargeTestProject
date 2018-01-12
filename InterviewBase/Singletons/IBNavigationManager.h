//
//  IBNavigationManager.h
//  InterViewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kNavigationManager [IBNavigationManager getInstance]

@interface IBNavigationManager : NSObject
{
    UIView *loadingView;
}

@property (nonatomic, strong) UIViewController *rootViewController;
@property (nonatomic, strong) UIWindow *window;

+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;

+ (IBNavigationManager *)getInstance;

- (void)showLoadingIndicator:(BOOL)loading;

@end
