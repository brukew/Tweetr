//
//  TweetCell.m
//  twitter
//
//  Created by Bruke Wossenseged on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
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
             if(error){
                  NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
             }
         }];
        [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    }
    else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
             if(error){
                  NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
             }
             else{
                 NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
             }
         }];
        [self.rtButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    [self refreshData];
}

@end
