//
//  RemoteDataController.h
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@class User;
@class RemoteDataController;
@import UIKit;

@protocol RemoteImageDelegate <NSObject>
@required
- (void) didRetrieveRemoteImage :(UIImage *) img inController:(RemoteDataController *) controller;
@end

@protocol RemoteDataDelegate <NSObject>
@required
- (void) didReceiveUserList :(NSArray<User *> *) userList inController:(RemoteDataController *) controller;
@end

@interface RemoteDataController : NSObject

- (void) downloadImageAtURL:(NSURL *) url into:(UIImageView *)imgView delegate:(NSObject<RemoteImageDelegate> *)delegate;
- (void) updateDataWithDelegate: (id <RemoteDataDelegate>) delegate;
+ (RemoteDataController *) sharedInstance;
+ (void) setSharedInstance:(RemoteDataController *)val;
@property (nonatomic) Boolean isDownloading;


@end
