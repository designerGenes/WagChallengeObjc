//
//  UserTableViewDataSource.h
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RemoteDataController.h"
#import "SBJson5/SBJson5.h"
@class User;
#import "UIColor+Convenience.h"
@import UIKit;


@interface UserTableViewDataSource : NSObject <RemoteDataDelegate, UITableViewDelegate, UITableViewDataSource>

- (void) adoptTableView: (UITableView* ) tableView;

@property (weak, nonatomic) UITableView *tableView;
@property (nonatomic) NSArray<User *>* userList;
+ (UserTableViewDataSource *) sharedInstance;
+ (void) setSharedInstance:(UserTableViewDataSource *)val;
@end
