//
//  DetailsViewController.h
//  twitter
//
//  Created by Bruke Wossenseged on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimelineViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol DetailsViewControllerDelegate

- (void)didLeave;

@end

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) Tweet *tweet;

@property (nonatomic, weak) id<DetailsViewControllerDelegate> delegate;


@end

NS_ASSUME_NONNULL_END
