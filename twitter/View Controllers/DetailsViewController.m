//
//  DetailsViewController.m
//  twitter
//
//  Created by Bruke Wossenseged on 7/1/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "ComposeViewController.h"
#import "DateTools.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profPicLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *bodyLabel;
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;
@property (weak, nonatomic) IBOutlet UILabel *rtLabel;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;
@property (weak, nonatomic) IBOutlet UIButton *favButton;
@property (weak, nonatomic) IBOutlet UIButton *rtButton;
@property (weak, nonatomic) IBOutlet UIView *tweetView;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fillView];
    // Do any additional setup after loading the view.
}

- (void)fillView{
    self.tweetView.layer.borderWidth = 1.0f;

    self.tweetView.layer.borderColor = [UIColor grayColor].CGColor;
    NSString *URLString = self.tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    self.profPicLabel.image = nil;
    self.profPicLabel.layer.cornerRadius = self.profPicLabel.frame.size.width / 2;
    self.profPicLabel.clipsToBounds = YES;
    [self.profPicLabel setImageWithURL:url];
    
    
    self.nameLabel.text = self.tweet.user.name;
    self.userLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.bodyLabel.text = self.tweet.text;
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

- (IBAction)retweet:(id)sender {
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

- (IBAction)favorite:(id)sender {
    if (!(self.tweet.favorited)){
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         }];
        CGRect favFrame = self.favButton.frame;
        favFrame.origin.y += 2;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    }
    else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
         }];
        CGRect favFrame = self.favButton.frame;
        favFrame.origin.y -= 2;
        [self.favButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    [self refreshData];
}



@end
