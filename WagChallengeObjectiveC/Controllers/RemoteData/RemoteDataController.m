//
//  RemoteDataController.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "RemoteDataController.h"
#import "AFNetworking/AFNetworking.h"
#import "UIKit+AFNetworking.h"
#import "SBJson5/SBJson5.h"
#import "User.h"
@class User;

NSString* BASE_URL_STRING = @"https://api.stackexchange.com/2.2/users?site=stackoverflow";

@interface RemoteDataController ()
    @property NSMutableDictionary* activeDownloaders;
    @property (strong) AFHTTPSessionManager* sessionManager;
    @property NSURL *baseURL;
@end



@implementation RemoteDataController

static RemoteDataController *sharedInstance;
+ (RemoteDataController*) sharedInstance { @synchronized(self) { return sharedInstance; } }
+ (void) setSharedInstance:(RemoteDataController *)val { @synchronized(self) { sharedInstance = val; } }


- (instancetype)init {
    self = [super init];
    if (self) {
        _baseURL = [NSURL URLWithString:BASE_URL_STRING];
        _activeDownloaders = [NSMutableDictionary dictionary];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        _sessionManager = [[AFHTTPSessionManager alloc] initWithSessionConfiguration:configuration];
    }
    return self;
}

// needs callback
- (void) downloadImageAtURL:(NSURL *) url into:(UIImageView *)imgView delegate:(NSObject<RemoteImageDelegate> *)delegate {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [imgView setImageWithURLRequest:request placeholderImage:nil success:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, UIImage * _Nonnull image) {
        [delegate didRetrieveRemoteImage:image inController:self];
    } failure:^(NSURLRequest * _Nonnull request, NSHTTPURLResponse * _Nullable response, NSError * _Nonnull error) {
        NSLog(@"failed to download img: %@", error.localizedDescription);
    }];
}

-(void)updateDataWithDelegate:(id<RemoteDataDelegate>)delegate {
    NSLog(@"updating data");
    [_sessionManager GET:BASE_URL_STRING parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            if ([NSJSONSerialization isValidJSONObject:responseObject] == YES) {
                NSLog(@"it's a real JSON object");
                if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *jsonDict = responseObject;
                    
                    // Process data
                    NSArray* items = [jsonDict objectForKey:@"items"];
                    NSLog(@"downloaded %i users", items.count);
                    
                    NSMutableArray<User *> *userList = [[NSMutableArray alloc] init];
                    for (NSDictionary *userDict in items) {
                        User *newUser = [User initFromJSON:userDict];
                        [userList addObject:newUser];
                    }
                    
                    [delegate didReceiveUserList:userList inController:self];
                }
                
            }
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed to get JSON response");
    }];
    
    
    

}

@end
