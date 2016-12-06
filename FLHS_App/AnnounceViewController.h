//
//  AnnounceViewController.h
//  FLHS_App
//
//  Created by Jacob Rauch on 1/14/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnnounceViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webScreen;
    IBOutlet UITextView *announce;
    IBOutlet UIBarButtonItem *refreshButton;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

-(IBAction)refresh:(id)sender;




@end
