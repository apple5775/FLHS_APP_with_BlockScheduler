//
//  menusViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 3/4/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "menusViewController.h"
#import "SWRevealViewController.h"

@interface menusViewController ()

@end

@implementation menusViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0  green:243/255.0  blue:243/255.0  alpha:1];
    _sidebarButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:1];

    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //self.navigationItem.leftBarButtonItem = _sidebarButton;
    
    [webScreen loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://drive.google.com/viewerng/viewer?url=http://www.bcsdny.org/files/filesystem/flhslunchmenu1.pdf"]]];
    
    [super viewDidLoad];
}


-(void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
     NSLog(@"Failed: %@", error);
}
    
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
