//
//  tempSportsViewController.h
//  FLHS_App
//
//  Created by Jacob Rauch on 11/11/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface tempSportsViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webScreen;
}

@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;



@end
