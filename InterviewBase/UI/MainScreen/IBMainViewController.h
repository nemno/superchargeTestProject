//
//  IBMainViewController.h
//  InterviewBase
//
//  Created by Nemes Norbert on 12/19/17.
//  Copyright © 2017 Nemes Norbert. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IBBaseViewController.h"
#import "IBProgramCollectionView.h"

@interface IBMainViewController : IBBaseViewController {
    IBProgramCollectionView *collectionView;
}

@end
