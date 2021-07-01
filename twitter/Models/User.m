//
//  User.m
//  twitter
//
//  Created by Bruke Wossenseged on 6/28/21.
//  Copyright © 2021 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profilePicture = dictionary[@"profile_image_url_https"];
        self.backdropPicture = dictionary[@"profile_background_image_url"];
        self.followerCount = dictionary[@"followers_count"];
        self.followingCount = dictionary[@"following"];
        self.tweetCount = dictionary[@"retweet_count"];
        
    // Initialize any other properties
    }
    return self;
}

@end
