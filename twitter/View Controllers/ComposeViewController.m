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

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *tweetButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_textView becomeFirstResponder];
    // Do any additional setup after loading the view.
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
