//
//  IBPopupView.m
//  InterviewBase
//
//  Created by Norbert Nemes on 2018. 01. 11..
//  Copyright © 2018. Nemes Norbert. All rights reserved.
//

#import "IBPopupView.h"

@implementation IBPopupView

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSArray *)otherButtonTitles {
    self = [super initWithFrame:kScreenBounds];
    
    if (self) {
        self.frame = kScreenBounds;
        
        self.backgroundColor = [UIColor clearColor];
        
        UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleProminent];
        containerView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
        containerView.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), 100.0f);
        containerView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        containerView.clipsToBounds = YES;
        [self addSubview:containerView];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(25.0f, 20.0f, CGRectGetWidth(self.frame) - 105.0f, 10.0f)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont systemFontOfSize:15.0f];
        titleLabel.numberOfLines = 0;
        titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        titleLabel.text = title;
        [titleLabel sizeToFit];
        [containerView.contentView addSubview: titleLabel];
        
        messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMinX(titleLabel.frame), CGRectGetMaxY(titleLabel.frame) + 11.0f, CGRectGetWidth(self.frame) - 50.0f, 10.0f)];
        messageLabel.backgroundColor = [UIColor clearColor];
        messageLabel.textAlignment = NSTextAlignmentLeft;
        messageLabel.textColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.5f];
        messageLabel.font = [UIFont systemFontOfSize:12.0f weight:UIFontWeightMedium];
        messageLabel.numberOfLines = 0;
        messageLabel.lineBreakMode = NSLineBreakByWordWrapping;
        messageLabel.text = message;
        [messageLabel sizeToFit];
        [containerView.contentView addSubview: messageLabel];
        
        NSMutableArray *buttonTitlesArray = [NSMutableArray arrayWithArray:otherButtonTitles];
        if (cancelButtonTitle) {
            [buttonTitlesArray insertObject:cancelButtonTitle atIndex:0];
        }
        
        NSInteger buttonIndex = 0;
        CGFloat buttonMinY = CGRectGetMaxY(messageLabel.frame) + 14.0f;
        NSMutableArray *tempButtonsArray = [NSMutableArray new];
        
        for (NSString *buttonTitle in buttonTitlesArray) {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0.0f, buttonMinY, CGRectGetWidth(self.frame), 44.0f);
            button.backgroundColor = [UIColor clearColor];
            [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:0.0f / 255.0f alpha:0.06f] size:button.frame.size] forState:UIControlStateHighlighted];
            button.titleLabel.font = [UIFont systemFontOfSize:17.0f];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor colorWithWhite:0.0f / 255.0f alpha:0.5f] forState:UIControlStateDisabled];
            [button setTitle:buttonTitle forState:UIControlStateNormal];
            button.layer.borderColor = [UIColor colorWithRed:200.0f / 255.0f  green:199.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f].CGColor;
            button.layer.borderWidth = 1.0f;
            button.tag = buttonIndex;
            [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
            buttonMinY = CGRectGetMaxY(button.frame) - 1.0f;
            buttonIndex++;
            [containerView.contentView addSubview:button];
            
            UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, CGRectGetWidth(button.frame), 1.0f)];
            separatorView.backgroundColor = [UIColor colorWithRed:200.0f / 255.0f  green:199.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f];
            [button addSubview:separatorView];
            [tempButtonsArray addObject:button];
        }
        
        buttonsArray = [NSArray arrayWithArray:tempButtonsArray];
        
        containerView.frame = CGRectMake(0.0f, kScreenHeight, CGRectGetWidth(self.frame), buttonMinY);
        
        if (buttonMinY != CGRectGetMaxY(messageLabel.frame) + 14.0f) {
            UIView *separatorView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, CGRectGetHeight(containerView.frame) - 1.0f, CGRectGetWidth(containerView.frame), 1.0f)];
            separatorView.backgroundColor = [UIColor colorWithRed:200.0f / 255.0f  green:199.0f / 255.0f blue:204.0f / 255.0f alpha:1.0f];
            separatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
            containerView.autoresizesSubviews = YES;
            [containerView.contentView addSubview:separatorView];
        }
    }
    
    return self;
}

- (void)show {
    [kNavigationManager.window addSubview:self];
    
    [UIView animateWithDuration:0.4f delay:0.0f options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.6f];
    } completion:^(BOOL finished) {
        
    }];
    
    [UIView animateWithDuration:0.4f delay:0.0f usingSpringWithDamping:0.5f initialSpringVelocity:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        if (CGRectGetHeight(containerView.frame) > kScreenHeight) {
            self.frame = CGRectMake(0.0f, 0.0f, CGRectGetWidth(self.frame), CGRectGetHeight(self.frame));
            containerView.frame = CGRectMake(0.0f, 20.0f, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame));
        } else {
            containerView.center = CGPointMake(CGRectGetWidth(self.frame) / 2.0f, CGRectGetHeight(self.frame) / 2.0f);
        }
    } completion:^(BOOL finished) {
        if (finished) {
            
        }
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:0.2f delay:0.0f options:UIViewAnimationOptionCurveEaseIn animations:^{
        self.backgroundColor = [UIColor colorWithWhite:0.0f / 255.0f alpha:0.0f];
        containerView.frame = CGRectMake(0.0f, kScreenHeight, CGRectGetWidth(containerView.frame), CGRectGetHeight(containerView.frame));
    } completion:^(BOOL finished) {
        if (finished) {
            [self removeFromSuperview];
        }
    }];
}

#pragma mark UIButton callback methods

- (void)buttonPressed:(UIButton *)button {
    [self dismiss];
    
    if (button.tag > 0) {
    } else {
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
