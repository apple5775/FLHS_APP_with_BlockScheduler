//
//  CalendarViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 2/20/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "CalendarViewController.h"
#import "SWRevealViewController.h"


@interface CalendarViewController ()
@property (weak, nonatomic) IBOutlet UIToolbar *calTool;

@end

@implementation CalendarViewController

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
    
    //self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:243/255.0  green:243/255.0  blue:243/255.0  alpha:1];
    //_sidebarButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:1];
    
    forButton.tintColor = [UIColor colorWithRed:134/255.0 green:0/255.0 blue:0/255.0 alpha:.5];
    backButton.tintColor = [UIColor colorWithRed:134/255.0 green:0/255.0 blue:0/255.0 alpha:.5];
        
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.title = @"Loading...";
    
    [webScreen setDelegate:self];
    
    NSURL *url = [NSURL URLWithString:@"http://www.bcsdny.org/calendar_events.cfm?printpage=1"];
    [webScreen loadRequest:[NSURLRequest requestWithURL:url]];
    
    NSCalendar *calendar= [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit;
    NSDate *date = [NSDate date];
    NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:date];
    newMonth = (int)[dateComponents month];
    newYear = (int)[dateComponents year];

}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    self.title = @"Calendar";
}

-(IBAction)backAct:(id)sender {
    self.title = @"Loading...";
    
    if (newMonth == 1) {
        NSString *string = [NSString stringWithFormat:@"http://www.bcsdny.org/calendar_events.cfm?theyear=%i&themonth=%i&cat=0&location=1&buildit=1&dir=&keyword=&printpage=1&&AddSportingEvents=0",newYear-1,newMonth+11];
        NSURL *newURL = [NSURL URLWithString:string];
        [webScreen loadRequest:[NSURLRequest requestWithURL:newURL]];
        
        newMonth = newMonth+11;
        newYear = newYear-1;
        
        //NSLog(@"month:%i year:%i", newMonth, newYear);
        
    }else {
        NSString *string = [NSString stringWithFormat:@"http://www.bcsdny.org/calendar_events.cfm?theyear=%i&themonth=%i&cat=0&location=1&buildit=1&dir=&keyword=&printpage=1&&AddSportingEvents=0",newYear,newMonth-1];
        NSURL *newURL = [NSURL URLWithString:string];
        [webScreen loadRequest:[NSURLRequest requestWithURL:newURL]];
        
        newMonth = newMonth-1;
        
        //NSLog(@"month:%i year:%i", newMonth, newYear);
    }
}
-(IBAction)forAct:(id)sender{
    self.title = @"Loading...";
    
    if (newMonth == 12) {
        NSString *string = [NSString stringWithFormat:@"http://www.bcsdny.org/calendar_events.cfm?theyear=%i&themonth=%i&cat=0&location=1&buildit=1&dir=&keyword=&printpage=1&&AddSportingEvents=0",newYear+1,newMonth-11];
        NSURL *newURL = [NSURL URLWithString:string];
        [webScreen loadRequest:[NSURLRequest requestWithURL:newURL]];
        
        newMonth = newMonth-11;
        newYear = newYear+1;
        
        //NSLog(@"month:%i year:%i", newMonth, newYear);
        
    }else {
        NSString *string = [NSString stringWithFormat:@"http://www.bcsdny.org/calendar_events.cfm?theyear=%i&themonth=%i&cat=0&location=1&buildit=1&dir=&keyword=&printpage=1&&AddSportingEvents=0",newYear,newMonth+1];
        NSURL *newURL = [NSURL URLWithString:string];
        [webScreen loadRequest:[NSURLRequest requestWithURL:newURL]];
        
        newMonth = newMonth+1;
        
        //NSLog(@"month:%i year:%i", newMonth, newYear);
    }
}

-(IBAction)webRefresh:(id)sender {
    self.title = @"Refreshing...";
    
    NSString *string = [NSString stringWithFormat:@"http://www.bcsdny.org/calendar_events.cfm?theyear=%i&themonth=%i&cat=0&location=1&buildit=1&dir=&keyword=&printpage=1&&AddSportingEvents=0",newYear,newMonth];
    NSURL *newURL = [NSURL URLWithString:string];
    [webScreen loadRequest:[NSURLRequest requestWithURL:newURL]];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
