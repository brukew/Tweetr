//
//  TweetCell.m
//  twitter
//
//  Created by Bruke Wossenseged on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"
#import "UIImageView+AFNetworking.h"
#import "UIButton+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void) loadData{
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    //self.pfpButton.image = nil;
    self.profilePicLabel.layer.borderWidth = 1.0f;

    self.profilePicLabel.layer.borderColor = [UIColor grayColor].CGColor;
    
    self.profilePicLabel.layer.cornerRadius = self.profilePicLabel.frame.size.width / 2;
    self.profilePicLabel.clipsToBounds = YES;
    [self.profilePicLabel setImageWithURL:url];
    
    
    
    self.nameLabel.text = self.tweet.user.name;
    self.userLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.bodyLabel.text = self.tweet.text;
    self.dateLabel.text = [NSString stringWithFormat:@"·%@", self.tweet.timeSince];
    self.favLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.rtLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.replyLabel.text = [NSString stringWithFormat:@"%i", self.tweet.replyCount];
    
    if (self.tweet.favorited){
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
        
    }
    else{
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    
    if (self.tweet.retweeted){
        [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    else{
        [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
}

- (void)refreshData{
    self.favLabel.text = [NSString stringWithFormat:@"%i", self.tweet.favoriteCount];
    self.rtLabel.text = [NSString stringWithFormat:@"%i", self.tweet.retweetCount];
    self.replyLabel.text = [NSString stringWithFormat:@"%i", self.tweet.replyCount];
     
}

- (IBAction)didTapFavorite:(UIButton *)sender {
    if (!(self.tweet.favorited)){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
             }
         }];
        CGRect favFrame = self.favButton.frame;
        favFrame.origin.y += 2;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
             }
         }];
        CGRect favFrame = self.favButton.frame;
        favFrame.origin.y -= 2;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    [self refreshData];
}

- (IBAction)didTapRetweet:(id)sender {
    if (!(self.tweet.retweeted)){
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         }];
        [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
         }];
        [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    [self refreshData];
}


@end
