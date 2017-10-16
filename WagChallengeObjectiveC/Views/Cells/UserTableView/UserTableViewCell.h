//
//  UserTableViewCell.h
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IconBadge.h"
#import "User.h"
#import "RemoteDataController.h"

@interface UserTableViewCell : UITableViewCell <RemoteImageDelegate>;
@property (weak, nonatomic) IBOutlet UIImageView *gravatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *displayNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *badgeCountLabel;
@property (nonatomic) NSArray<IconBadge *>* iconBadges;
@property (nonatomic, weak) NSAttributedString* displayName;
@property (nonatomic, weak) NSAttributedString* badgeCountText;
@property (nonatomic, weak) UIImage* gravatarImage;


- (void) touchedDownOnBadgeCount: (UIControl*) control;
- (void) touchedDownOnBadge: (UIControl*) control;
- (void) revealDescriptionForBadge: (IconBadge*) badge;
- (void) resetToNormalLayout;
- (void) layoutIconBadgesFor: (User*) user;
- (NSAttributedString *) makeBadgeCountTextWithGoldStr: (NSString *) goldStr silvStr:(NSString *)silvStr brnzStr:(NSString *)brnzStr :(CGFloat) size;
- (void) drawBadgeCountTextFor: (User*) user;
- (void) downloadGravatarFrom: (NSURL*) url;
- (void) adoptUser: (User *) user;

@end
