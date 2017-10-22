//
//  User.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "User.h"

@implementation User
+ (User *) initFromJSON:(NSDictionary *)json {
    User *newUser = [[User alloc] init];
    [newUser setDisplayName:[json valueForKey:@"display_name"]];
    [newUser setReputation:[json valueForKey:@"reputation"]];
    
    NSDictionary *badgeCounts = [json valueForKey:@"badge_counts"];
    [newUser setGoldCount:[badgeCounts valueForKey:@"gold"]];
    [newUser setSilverCount:[badgeCounts valueForKey:@"silver"]];
    [newUser setBronzeCount:[badgeCounts valueForKey:@"bronze"]];
    
    NSString *gravatarURLString = [json valueForKey:@"profile_image"];
    [newUser setGravatarURL:[NSURL URLWithString:gravatarURLString]];
    NSLog(@"created user with url %@", gravatarURLString);
//    NSLog(@"created %@ with %@ gold, %@ silver, and %@ bronze medals, and %@ reputation ",
//          newUser.displayName,
//          newUser.goldCount, newUser.silverCount, newUser.bronzeCount, newUser.reputation);
    return newUser;
}
@end
