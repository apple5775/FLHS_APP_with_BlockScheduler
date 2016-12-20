//
//  tempSportsViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 11/11/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "tempSportsViewController.h"
#import "SWRevealViewController.h"
@interface tempSportsViewController ()

@end

@implementation tempSportsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //Comment Here
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0  green:243/255.0  blue:243/255.0  alpha:1];
    _sidebarButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:1];
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    self.navigationItem.leftBarButtonItem = _sidebarButton;
    self.navigationItem.rightBarButtonItem = nil;
    
    NSURL *url = [NSURL URLWithString:@"http://sportspak.swboces.org/sportspak/oecgi3.exe/O4W_GAMES_SCHEDS"];
    [webScreen loadRequest:[NSURLRequest requestWithURL:url]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
