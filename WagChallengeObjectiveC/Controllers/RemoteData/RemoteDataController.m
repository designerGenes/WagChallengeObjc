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

-(void)processData: (NSDictionary*)data {
    NSArray* items = [[data objectForKey:@"items"] array];
    NSLog(@"downloaded %i items", items.count);
//    NSMutableArray<User> userList = [items ]
    
//    if let items = resultJSON["items"].array {
//        print("downloaded \(items.count) JSON user objects ")
//        // get average reputation.  This method is imperfect because
//        // we are only comparing against the current page and would be implemented
//        // differently in a full app
//        let reputationArr = items.filter({$0["reputation"].int != nil}).map({$0["reputation"].intValue})
//        let averageRep = reputationArr.reduce(0, {$0 + $1}) / reputationArr.count
//        User.averageReputation = averageRep
//        print("average User Reputation is \(averageRep)")
//
//        let userList: [User] = items.map({ User(fromJSON: $0) })
//        print("generated list of \(userList.count) users")
//        delegate?.didReceiveUserList(list: userList, in: self)
//
//    }
//
//}
}

-(void)updateDataWithDelegate:(id<RemoteDataDelegate>)delegate {
    NSLog(@"updating data");
//    _sessionManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [_sessionManager GET:BASE_URL_STRING parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject != nil) {
            if ([NSJSONSerialization isValidJSONObject:responseObject] == YES) {
                NSLog(@"it's a real JSON object");
//                NSLog(@"%@", responseObject);
                NSError *error;
                NSMutableDictionary *jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:&error];
                NSLog(@"%@", jsonDict);
            }
            
//            NSDictionary* jsonDict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers
//                                                                       error:nil];
//            [self processData:jsonDict];
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"failed to get JSON response");
    }];
    
    
    

}

@end
