//
//  RemoteDataController.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "RemoteDataController.h"
#import "AFNetworking/AFNetworking.h"
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
- (void) downloadImageAtURL:(NSURL *) url delegate:(UIImageView *)delegate {
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [_sessionManager dataTaskWithRequest: request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (error != nil) {
            NSLog(@"%@", error.localizedDescription);
        } else {
            
            
        }
    }]
//    [_sessionManager ]
    
//    if let sessionManager = sessionManager {
//        let urlRequest = URLRequest(url: url)
//        if let cachedImg = imageCache.image(for: urlRequest, withIdentifier: url.absoluteString) {
//            callback?(cachedImg)
//        } else {
//            let downloader = ImageDownloader(sessionManager: sessionManager)
//            activeDownloaders[url] = downloader
//            downloader.download(urlRequest, filter: nil) { res in
//                DispatchQueue.main.async {
//                    guard res.error == nil else {
//                        print("Error: \(res.error!.localizedDescription)")
//                        callback?(nil)
//                        return
//                    }
//                    let img = res.result.value
//                    if let img = img {
//                        self.imageCache.add(img, for: urlRequest, withIdentifier: url.absoluteString)
//                    }
//                    callback?(img)
//                    self.activeDownloaders[url] = nil
//                }
//            }
//        }
//    }
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
