//
//  NSNumber+Convenience.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "NSNumber+Convenience.h"

@implementation NSNumber (Convenience)

-(NSString *) withFixedDigitCount: (int) digitCount
{
    NSMutableString *strSelf = [NSMutableString stringWithString:self.stringValue];
    if (strSelf.length > digitCount) {
        NSMutableString *nines = [NSMutableString string];
        for (int z = 0; z < digitCount; z++) {
            [nines appendString:@"9"];
        }
        [nines insertString:@"+" atIndex:0];
        return nines;
    }
    
    while (strSelf.length < digitCount) {
        [strSelf insertString:@"0" atIndex:0];
    }
    
    return strSelf;
}

@end
