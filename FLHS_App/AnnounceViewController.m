//
//  AnnounceViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 1/14/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "AnnounceViewController.h"
#import "SWRevealViewController.h"

@interface AnnounceViewController ()

@end

@implementation AnnounceViewController

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
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];

    
    self.title = @"Loading...";
    
    [webScreen setDelegate:self];
    
    NSURL *url = [NSURL URLWithString:@"http://bcsdny.org/flhs.cfm?subpage=1841"];
    [webScreen loadRequest:[NSURLRequest requestWithURL:url]];
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.title = @"Announcements";
    
    NSString *html = [webScreen stringByEvaluatingJavaScriptFromString:@"document.getElementById('sw-contentInner').innerText"];
    NSString *aText1 = [html stringByReplacingOccurrencesOfString:@"Fox Lane High School » Daily Announcements" withString:@""];
    NSString *aText2 = [aText1 stringByReplacingOccurrencesOfString:@"Daily Announcements" withString:@""];
    
    announce.text = aText2;
}

-(IBAction)refresh:(id)sender {
    
    self.title = @"Refreshing...";
    
    NSURL *url = [NSURL URLWithString:@"http://bcsdny.org/flhs.cfm?subpage=1841"];
    [webScreen loadRequest:[NSURLRequest requestWithURL:url]];
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
