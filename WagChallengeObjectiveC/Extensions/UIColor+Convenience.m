//
//  UIColor+UIColor_Convenience.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "UIColor+Convenience.h"
#import "Enumerations.h"


@implementation UIColor (Convenience)
+ (UIColor *) initFromHexString: (NSString *) hexString
{
    NSString *cString = [[hexString stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    UInt32 rgbValue = 0;
    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }
    NSScanner *scanner = [[NSScanner alloc] initWithString:cString];
    [scanner scanHexInt:&rgbValue];
    UIColor *result = [UIColor colorWithRed: ((rgbValue & 0xFF0000) >> 16) / 255.0
                                     green:((rgbValue & 0x00FF00) >> 8) / 255.0
                                       blue:(rgbValue & 0x0000FF) / 255.0
                                      alpha:1.0];
   
    return result;
}

+ (UIColor *) initFromNamedColor: (DesignColor) name
{
    
    NSDictionary *colorDict = @{
               [NSNumber numberWithInt:bronze] : @"#F2895B",
               [NSNumber numberWithInt:silver] : @"#EEEEEE",
               [NSNumber numberWithInt:gold] : @"#FFBC42",
               [NSNumber numberWithInt:gray_0] : @"#232323",
               [NSNumber numberWithInt:gray_1] : @"#303030",
               [NSNumber numberWithInt:gray_2] : @"#595959",
   };
    
    return [UIColor initFromHexString:[colorDict objectForKey:[NSNumber numberWithInt:name]]];
}
@end
