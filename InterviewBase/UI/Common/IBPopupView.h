//
//  IBPopupView.h
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 11..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IBPopupView : UIView
{
    UIVisualEffectView *containerView;
    UILabel *titleLabel;
    UILabel *messageLabel;
    NSArray *buttonsArray;
}

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles;

- (void)show;
- (void)dismiss;

@end
