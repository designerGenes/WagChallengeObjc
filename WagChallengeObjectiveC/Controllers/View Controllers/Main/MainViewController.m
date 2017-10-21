//
//  MainViewController.m
//  WagChallengeObjectiveC
//
//  Created by Jaden Nation on 10/14/17.
//  Copyright © 2017 Designer Jeans. All rights reserved.
//

#import "MainViewController.h"
#import "UserTableViewDataSource.h"


@interface MainViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property UILabel *contentLoadingLabel;
@property UIActivityIndicatorView *activityIndicator;
@end

@implementation MainViewController

    // methods
-(void)viewDidLayoutSubviews {
    _contentLoadingLabel.center = [self view].center;
    _activityIndicator.center = [[self view] center];
    _activityIndicator.transform = CGAffineTransformMakeTranslation(0, 32);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _contentLoadingLabel = [[UILabel alloc] init];
    _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:(UIActivityIndicatorViewStyleWhite)];
    [[UserTableViewDataSource sharedInstance] adoptTableView:_tableView];
    // Do any additional setup after loading the view, typically from a nib.
}



@end
