//
//  UserTableViewCell.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "UserTableViewCell.h"
#import "IconBadge.h"
#import "Enumerations.h"
#import "UIColor+Convenience.h"
#import "NSNumber+Convenience.h"
#import "RemoteDataController.h"
@import UIKit;

UIFont *sfBold;

@interface UserTableViewCell ()
@property (nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation UserTableViewCell

// RemoteImageDelegate methods
- (void) didRetrieveRemoteImage :(UIImage *) img :(id *) remoteDataController {
    
    // needs to be on main async queue
    
    // process here to round corners of img
    
    [_gravatarImageView setImage:img];
    self.gravatarImage = img;
    [[self activityIndicator] stopAnimating];
}


// touch response methods
- (void) touchedDownOnBadgeCount: (UIControl *) control {
    NSAttributedString *badgeDescriptionText = [self makeBadgeCountText:@"GOLD" :@"SLVR" :@"BRNZ" :24];
    [_displayNameLabel setAttributedText:badgeDescriptionText];
}
- (void) touchedDownOnBadge: (UIControl *) control {
    
}

- (void) revealDescriptionForBadge: (IconBadge *) badge {
    NSMutableAttributedString *loreString = [ [NSMutableAttributedString alloc] initWithString:badge.lore];
    [loreString addAttribute: NSFontAttributeName
                       value:sfBold range:NSMakeRange(0, loreString.length)];
    [loreString addAttribute: NSForegroundColorAttributeName
                       value:[UIColor whiteColor] range:NSMakeRange(0, loreString.length)];
    
    [_displayNameLabel setAttributedText:loreString];
    
}
- (void) resetToNormalLayout {
    for (IconBadge* badge in _iconBadges) {
        [badge setAlpha:1];
        [badge setTransform:CGAffineTransformIdentity];
    }
    [_badgeCountLabel setAttributedText:_badgeCountText];
    [_displayNameLabel setAttributedText:_displayName];
    [_gravatarImageView setImage:_gravatarImage];
}
- (void) layoutIconBadgesFor: (User *) user {
    
}
- (NSAttributedString *) makeBadgeCountText :(NSString *)goldStr :(NSString *)silvStr :(NSString *)brnzStr :(CGFloat) size {
    NSMutableAttributedString *badgeCountAttributedString = [[NSMutableAttributedString alloc] initWithString:@""];
    NSArray *badgeColors = @[ [UIColor initFromNamedColor:gold], [UIColor initFromNamedColor:silver], [UIColor initFromNamedColor:bronze] ];
    
    for (int z=0;z<badgeColors.count; z++) {
        NSString *badgeCountRaw = [@[goldStr, silvStr, brnzStr] objectAtIndex:z];
        UIColor *assocColor = [badgeColors objectAtIndex:z];
        
        NSNumber *numericForm = [NSNumber numberWithInteger:badgeCountRaw.integerValue];
        badgeCountRaw = [numericForm withFixedDigitCount:4];
        
        NSDictionary *attributes =@{
                                  NSFontAttributeName : sfBold,
                                  NSKernAttributeName : @1.5,
                                  NSForegroundColorAttributeName: assocColor
                                  };
        
        NSAttributedString *badgeCountColored = [[NSAttributedString alloc] initWithString:badgeCountRaw attributes:attributes];
        [badgeCountAttributedString appendAttributedString:badgeCountColored];
    }
    
    
    return badgeCountAttributedString;
}
- (void) drawBadgeCountTextFor: (User *) user {

    
    NSAttributedString *goldString = [[NSAttributedString alloc] initWithString:[
                                     NSString stringWithFormat:@"%@ ", user.goldCount] attributes:@{NSForegroundColorAttributeName:[UIColor initFromNamedColor:gold]}];
    
    NSAttributedString *silverString = [[NSAttributedString alloc] initWithString:[
                                                                                 NSString stringWithFormat:@"%@ ", user.silverCount] attributes:@{NSForegroundColorAttributeName:[UIColor initFromNamedColor:silver]}];
    
    NSAttributedString *bronzeString = [[NSAttributedString alloc] initWithString:[
                                                                                   NSString stringWithFormat:@"%@", user.bronzeCount] attributes:@{NSForegroundColorAttributeName:[UIColor initFromNamedColor:bronze]}];
    
    NSMutableAttributedString *badgeCountString = [[NSMutableAttributedString alloc] initWithAttributedString:goldString];
    [badgeCountString appendAttributedString:silverString];
    [badgeCountString appendAttributedString:bronzeString];
    [_badgeCountLabel setAttributedText:badgeCountString];
}



- (void) downloadGravatarFrom: (NSURL *) url {
    self.gravatarImageView.image = nil;
    [self addSubview:_activityIndicator];
    [_activityIndicator startAnimating];
    
    [[RemoteDataController sharedInstance] downloadImageAtURL:url delegate:_gravatarImageView];

}

- (void) adoptUser: (User *) user {
    NSMutableAttributedString *displayNameString = [[NSMutableAttributedString alloc] initWithString:user.displayName];

    [displayNameString addAttribute: NSForegroundColorAttributeName
                       value:[UIColor whiteColor] range:NSMakeRange(0, displayNameString.length)];
//
    [_displayNameLabel setAttributedText:displayNameString];
//
    [self drawBadgeCountTextFor:user];
    [self downloadGravatarFrom:user.gravatarURL];
    
}

// lifecycle methods
- (void)awakeFromNib {
    [super awakeFromNib];
    sfBold = [UIFont fontWithName:@"SanFranciscoDisplay-Bold" size:24];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    
}

-(void)layoutSubviews {
    [_activityIndicator setCenter:(_gravatarImageView.center)];
}

-(void)prepareForReuse {
    [super prepareForReuse];
    [_activityIndicator removeFromSuperview];
}



@end
