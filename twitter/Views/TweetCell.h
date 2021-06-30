//
//  TweetCell.h
//  twitter
//
//  Created by Bruke Wossenseged on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell

@property (nonatomic, strong) Tweet* tweet;

@property (weak, nonatomic) IBOutlet UIImageView *profPicLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rtLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;
@property (weak, nonatomic) IBOutlet UIButton *rtButton;
@property (weak, nonatomic) IBOutlet UIButton *favButton;

@end

NS_ASSUME_NONNULL_END
