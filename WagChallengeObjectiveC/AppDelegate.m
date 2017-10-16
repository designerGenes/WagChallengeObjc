//
//  AppDelegate.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "AppDelegate.h"
#import "RemoteDataController.h"
#import "UserTableViewDataSource.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [RemoteDataController setSharedInstance:[[RemoteDataController alloc] init]];
    [UserTableViewDataSource setSharedInstance:[[UserTableViewDataSource alloc] init]];
    
    [[RemoteDataController sharedInstance] updateDataWithDelegate:[UserTableViewDataSource sharedInstance]];
    return YES;
}



- (void)applicationDidEnterBackground:(UIApplication *)application {
   
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}


@end
