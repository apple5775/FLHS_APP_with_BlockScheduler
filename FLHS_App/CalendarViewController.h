//
//  CalendarViewController.h
//  FLHS_App
//
//  Created by Jacob Rauch on 2/20/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CalendarViewController : UIViewController <UIWebViewDelegate>{
    IBOutlet UIBarButtonItem *refreshButton;
    
    IBOutlet UIBarButtonItem *forButton;
    IBOutlet UIBarButtonItem *backButton;
    
    IBOutlet UIWebView *webScreen;
            
    int newMonth;
    int newYear;

}
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

-(IBAction)backAct:(id)sender;
-(IBAction)forAct:(id)sender;
-(IBAction)webRefresh:(id)sender;

@end
