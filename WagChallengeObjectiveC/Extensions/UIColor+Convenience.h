//
//  UIColor+Convenience.h
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Enumerations.h"

@interface UIColor (Convenience)
+ (UIColor *) initFromHexString: (NSString *) hexString;
+ (UIColor *) initFromNamedColor: (DesignColor) name;
@end
