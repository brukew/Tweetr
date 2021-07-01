//
//  ComposeViewController.m
//  twitter
//
//  Created by Bruke Wossenseged on 6/29/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "User.h"
#import "TimelineViewController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIImageView *pfpView;
@property (weak, nonatomic) NSDictionary *userInformation;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textView becomeFirstResponder];
    self.pfpView.layer.cornerRadius = self.pfpView.frame.size.width / 2;
    self.pfpView.clipsToBounds = YES;
    
    [[APIManager shared] getUserInfo: ^(NSDictionary *userInfo, NSError *error) {
        if(error){
                NSLog(@"Error getting info: %@", error.localizedDescription);
        }
        else{
            
            self.userInformation = userInfo;
            NSString *URLString = self.userInformation[@"profile_image_url"];
            NSURL *url = [NSURL URLWithString:URLString];
            [self.pfpView setImageWithURL:url];
            NSLog(@"Info secire Success!");
        }
    }];
    
    
}

- (IBAction)closeView:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)updateStatus:(id)sender {
    NSString *text = self.textView.text;
    //Tweet text
    [[APIManager shared] postStatusWithText:text completion: ^(Tweet *tweet, NSError *error) {
        if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else{
            [self.delegate didTweet:tweet];
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
        }
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
