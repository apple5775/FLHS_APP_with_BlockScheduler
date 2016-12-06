//
//  ViewController.h
//  FLHS_App
//
//  Created by Jacob Rauch on 12/9/13.
//  Copyright (c) 2013 Jacob Rauch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *schedWeb;
    IBOutlet UITextView *schedText;
    IBOutlet UIBarButtonItem *refreshButton;
    
    IBOutlet UIWebView *sportWeb;
    IBOutlet UITextView *sportText;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

-(IBAction)refresh:(id)sender;


@end
