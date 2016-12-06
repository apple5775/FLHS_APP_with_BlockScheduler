//
//  ViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 12/9/13.
//  Copyright (c) 2013 Jacob Rauch. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.title = @"Home";
    self.navigationController.navigationBarHidden = false;
    self.navigationController.navigationBar.userInteractionEnabled = true;
    // Change button color
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0  green:243/255.0  blue:243/255.0  alpha:1];
    _sidebarButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:1];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    schedText.text = @"Loading...";
    sportText.text = @"Loading...";
    [schedWeb setDelegate:self];
    [sportWeb setDelegate:self];
    
    NSURL *schedURL = [NSURL URLWithString:@"http://www.bcsdny.org/flhs.cfm?subpage=12"];
    [schedWeb loadRequest:[NSURLRequest requestWithURL:schedURL]];
    
    NSURL *sportURL = [NSURL URLWithString:@"http://sportspak.swboces.org/sportspak/oecgi3.exe/O4W_SPAKONLINE_HOME"];
    [sportWeb loadRequest:[NSURLRequest requestWithURL:sportURL]];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    if (webView == schedWeb)
    {
        NSString *schedHTML = [schedWeb stringByEvaluatingJavaScriptFromString:@"document.getElementById('sw-events').innerText"];
        NSArray *split = [schedHTML  componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        NSString *schedTextStr = @"";
        
        NSMutableArray *dateArray = [[NSMutableArray alloc]init];
        
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"EEEE, MMMM d"];
        int dayNum = 86400;
        for (int d = 0; d < 30; d++) {
            int tempNum = dayNum * d;
            NSDate *newDate = [NSDate dateWithTimeIntervalSinceNow:tempNum];
            NSString *newDateStr = [dateFormat stringFromDate:newDate];
            [dateArray addObject:newDateStr];
        }
        for (int i = 0; i < split.count; i++) {
            if ([dateArray containsObject:split[i]]) {
                schedTextStr = [schedTextStr stringByAppendingString:@"\n"];
            }
            schedTextStr = [schedTextStr stringByAppendingString:@"\n"];
            schedTextStr = [schedTextStr stringByAppendingString:split[i]];
        }
        schedText.text = [schedTextStr stringByTrimmingCharactersInSet:
                                       [NSCharacterSet whitespaceAndNewlineCharacterSet]];

    } else if (webView == sportWeb) {
        NSString *sportHTML = [sportWeb stringByEvaluatingJavaScriptFromString:@"document.getElementById('DAILY_EVENTS').innerText"];
        
        NSArray *split = [sportHTML  componentsSeparatedByCharactersInSet: [NSCharacterSet newlineCharacterSet]];
        NSString *sportTextStr = @"";
        
        for (int i = 0; i < split.count; i++) {
            if ([split[i] containsString:@"FOX"]) {
                NSString *temp = [split[i] stringByAppendingString:@"\n\n"];
                sportTextStr = [sportTextStr stringByAppendingString:temp];
            }
        }
        
         sportText.text = sportTextStr;
        if ([sportTextStr isEqualToString:@""]) {
            sportText.text = @"None";
        }
        
    }
}

-(IBAction)refresh:(id)sender {
    
    schedText.text = @"Refreshing...";
    NSURL *schedURL = [NSURL URLWithString:@"http://www.bcsdny.org/flhs.cfm?subpage=12"];
    [schedWeb loadRequest:[NSURLRequest requestWithURL:schedURL]];
    
    sportText.text = @"Refreshing...";
    NSURL *sportURL = [NSURL URLWithString:@"http://sportspak.swboces.org/sportspak/oecgi3.exe/O4W_SPAKONLINE_HOME"];
    [sportWeb loadRequest:[NSURLRequest requestWithURL:sportURL]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
