//
//  IBNavigationManager.m
//  InterViewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import "IBNavigationManager.h"
#import "IBMainViewController.h"

@implementation IBNavigationManager
@synthesize rootViewController;
@synthesize window;

+ (IBNavigationManager *)getInstance {
    static dispatch_once_t pred;
    __strong static id sharedInstance = nil;
    dispatch_once( &pred, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    
    if (self != nil) {
        [[UINavigationBar appearance] setTintColor:[UIColor blackColor]];
        
        self.rootViewController = [[IBMainViewController alloc] initWithNibName:nil bundle:nil];
    }
    
    return self;
}

- (void)showLoadingIndicator:(BOOL)loading {
    if (loadingView && loading) {
        return;
    } else if (!loadingView && !loading) {
        return;
    } else {
        if (loading) {
            loadingView = [[UIView alloc] initWithFrame:kScreenBounds];
            loadingView.backgroundColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.5f];
            loadingView.alpha = 0.0f;
            [self.window addSubview:loadingView];
            
            UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
            indicatorView.center = CGPointMake(CGRectGetWidth(loadingView.frame) / 2.0f, CGRectGetHeight(loadingView.frame) / 2.0f);
            [loadingView addSubview:indicatorView];
            [indicatorView startAnimating];
            
            [UIView animateWithDuration:0.2f animations:^{
                loadingView.alpha = 1.0f;
            }];
        } else {
            [UIView animateWithDuration:0.2f animations:^{
                loadingView.alpha = 0.0f;
            } completion:^(BOOL finished) {
                if (finished) {
                    [loadingView removeFromSuperview];
                }
            }];
        }
    }
}

@end
