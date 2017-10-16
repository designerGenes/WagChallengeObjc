//
//  UserTableViewDataSource.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "UserTableViewDataSource.h"
#import "Enumerations.h"
#import "UIColor+Convenience.h"
#import "UserTableViewCell.h"
@import UIKit;


@implementation UserTableViewDataSource
static UserTableViewDataSource *sharedInstance;
+ (UserTableViewDataSource *) sharedInstance { @synchronized(self) { return sharedInstance; } }
+ (void) setSharedInstance:(UserTableViewDataSource *)val { @synchronized(self) { sharedInstance = val; } }
- (void) didReceiveUserList :(NSArray<User *> *) userList inController:(RemoteDataController *) controller {
    self.userList = userList;
    [self.tableView reloadData];
    self.tableView.backgroundView.backgroundColor = self.userList.count % 2 == 0 ? [UIColor initFromNamedColor:gray_0] : [UIColor initFromNamedColor:gray_1];
    [self.tableView setValue:false forKey:@"isHidden"];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userList.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UIScreen.mainScreen.bounds.size.height / 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserTableViewCell *userCell = [tableView dequeueReusableCellWithIdentifier:@"UserTableViewCell" forIndexPath:indexPath];
    if (userCell != nil) {
        [userCell adoptUser:[_userList objectAtIndex:indexPath.row]];
        UIColor *alternatingCellShade = indexPath.row % 2 == 0 ? [UIColor initFromNamedColor:gray_1] : [UIColor initFromNamedColor:gray_0];
        [userCell.contentView setBackgroundColor:alternatingCellShade];
        [userCell setUserInteractionEnabled:YES];
        return userCell;
    }
    return [[UITableViewCell alloc] init];
}

- (void) adoptTableView: (UITableView *) tableView {
    self.tableView = tableView;
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat yVal = scrollView.contentOffset.y;
    if (yVal < 0) {
        [scrollView setContentOffset:(CGPointMake(0, 0))];
    }
}



@end
