//
//  User.h
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject
    @property (nonatomic) NSString* displayName;
    @property ( nonatomic) NSNumber* bronzeCount;
    @property (nonatomic) NSNumber* silverCount;
    @property (nonatomic) NSNumber* goldCount;
    @property (nonatomic) NSURL* gravatarURL;
    @property (nonatomic) NSNumber* reputation;
    +(User*) initFromJSON:(NSDictionary*)json;
@end
