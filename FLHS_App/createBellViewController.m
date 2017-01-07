//
//  createBellViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 2/25/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "createBellViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface createBellViewController ()

@end

@implementation createBellViewController {
    NSArray *_sched;
    NSMutableArray *_period;
    int lunch;
    NSString *titleString;
    NSString *day;
    NSString *dateString;
    NSString *advColString;
    NSDictionary *dayList;
    
    NSMutableArray *lunchE1;
    NSMutableArray *lunchE2;
    NSMutableArray *lunchE3;
    
    int currentCourse;
    
    NSMutableArray *courseFinal;
    NSMutableArray *timeFinal;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)goToInfo{
    [self performSegueWithIdentifier:@"info" sender:self];
}

-(void)refreshTable{
    [self viewWillAppear:YES];
}

-(void)splitLunches {
    lunchE1 = [[NSMutableArray alloc]init];
    lunchE2 = [[NSMutableArray alloc]init];
    lunchE3 = [[NSMutableArray alloc]init];
    
    NSString *lunchS1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"lunchE 1"];
    for (int x = 0; x < lunchS1.length; x++) {
        [lunchE1 addObject:[NSString stringWithFormat:@"%c",[lunchS1 characterAtIndex:x]]];
    }
    NSString *lunchS2 = [[NSUserDefaults standardUserDefaults]stringForKey:@"lunchE 2"];
    for (int x = 0; x < lunchS2.length; x++) {
        [lunchE2 addObject:[NSString stringWithFormat:@"%c",[lunchS2 characterAtIndex:x]]];
    }
    NSString *lunchS3 = [[NSUserDefaults standardUserDefaults]stringForKey:@"lunchE 3"];
    for (int x = 0; x < lunchS3.length; x++) {
        [lunchE3 addObject:[NSString stringWithFormat:@"%c",[lunchS3 characterAtIndex:x]]];
    }
}

-(void)highlightCourse {
    int i = 0;
    for (NSString *timeRange in _sched) {
        NSArray *split = [timeRange componentsSeparatedByString:@"-"];
        
        NSArray *start = [split[0] componentsSeparatedByString:@":"];
        NSArray *end = [split[1] componentsSeparatedByString:@":"];
        
        int startH = (int)[start[0] integerValue];
        int startM = (int)[start[1] integerValue];
        int endH = (int)[end[0] integerValue];
        int endM = (int)[end[1] integerValue];
        
        NSDate *today = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *startComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
        [startComp setHour:startH];
        [startComp setMinute:startM];
        NSDateComponents *endComp = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay fromDate:today];
        [endComp setHour:endH];
        [endComp setMinute:endM];
        NSDate *startTimeD = [calendar dateFromComponents:startComp];
        NSDate *endTimeD = [calendar dateFromComponents:endComp];
      
        NSComparisonResult startResult = [today compare:startTimeD];
        NSComparisonResult endResult = [today compare:endTimeD];
        
        if ((startResult == NSOrderedDescending && endResult == NSOrderedAscending)|| startResult == NSOrderedSame) {
            break;
        }else if (endResult == NSOrderedSame){
            i++;
            break;
        }else if (i == _sched.count-1){
            break;
        }
        i++;
    }
    currentCourse = i;
}


-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"doneB"]==false) {
        [self goToInfo];
        return;
    }
    
    [self.tableView reloadData];
    
    timeFinal = [[NSMutableArray alloc]init];
    courseFinal = [[NSMutableArray alloc]init];
    
    /*NSArray *checkDays = @[@"A",@"B",@"C",@"D",@"E",@"1",@"2",@"3",@"4",@"5",@"Weekend",@"Adv",@"Col",@"1HD",@"2HD"];
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"specialB"]==true) {
        PFQuery *query = [PFQuery queryWithClassName:@"Schedule"];
        [query whereKey:@"Name" equalTo:@"Day"];
        PFObject *object = [query getFirstObject];
        if (![object[@"Time"] isEqualToString:@"Normal"]) {
            if ([checkDays containsObject:object[@"Time"]]) {
                day = object[@"Time"];
            }else {
                day = @"special";
            }
        }
        [query cancel];
        query = NULL;
    }*/
    _sidebarButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:1];
    
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    UIButton* infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
    infoButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:.5];
	[infoButton addTarget:self action:@selector(goToInfo) forControlEvents:UIControlEventTouchUpInside];
	UIBarButtonItem *modalButton = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
    
    UIBarButtonItem *refreshButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refreshTable)];
    refreshButton.tintColor = [UIColor colorWithRed:181/255.0 green:12/255.0 blue:12/255.0 alpha:.5];
    
    [self.navigationItem setRightBarButtonItems:@[refreshButton,modalButton] animated:YES];

    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"specialB"]==false) {
        day = @"none"; //It will be changed if we find a correct day code.
        NSDate *today = [NSDate date];
        NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"MM/dd"];
        dateString = [dateFormat stringFromDate:today];
        [PFConfig getConfigInBackgroundWithBlock:^(PFConfig *config, NSError *error) {
            NSArray *days = config[@"WhatDay"];
            NSLog(@"Sucessfully accessed Day Codes %@", @"Yay!");
            NSString *separatingString = @":";
            for (NSString *dayCode in days) {
                NSArray *subStrings = [dayCode componentsSeparatedByString:separatingString];
                NSString *date = subStrings[0];
                NSLog(date);
                if ([date isEqualToString: dateString]) {
                    NSLog(subStrings[1]);
                    day = subStrings[1];
                    break;
                }
            }
            lunch = (int)[[NSUserDefaults standardUserDefaults] integerForKey: @"lunchNum"];
            
            NSString *c1 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 1"];
            NSString *c2 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 2"];
            NSString *c3 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 3"];
            NSString *c4 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 4"];
            NSString *c5 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 5"];
            NSString *c6 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 6"];
            NSString *c7 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 7"];
            NSString *c8 = [[NSUserDefaults standardUserDefaults]stringForKey:@"Course 8"];
            
            NSArray *timeLunch1 = @[@[@"7:45-8:40",@"8:45-9:40",@"9:45-10:20",@"10:25-11:20",@"11:25-12:20",@"12:25-1:20",@"1:25-2:20"],
                                    @[@"7:45-8:25",@"8:30-9:10",@"9:15-9:55",@"10:00-10:40",@"10:45-11:15",@"11:20-12:00",@"12:05-12:45",@"12:50-1:30",@"1:35-2:15"],
                                    @[@"7:45-8:20",@"8:25-9:00",@"9:05-9:30",@"9:35-10:10",@"10:15-10:55",@"11:00-11:35",@"11:40-12:15",@"12:20-12:55",@"1:00-1:35",@"1:40-2:15"],
                                    @[@"7:45-8:20",@"8:25-9:00",@"9:05-9:40",@"9:45-10:20",@"10:25-11:35",@"11:40-12:15",@"12:20-12:55",@"1:00-1:35",@"1:40-2:15"],
                                    @[@"9:45-10:10",@"10:15-10:40",@"10:45-11:10",@"11:15-11:45",@"11:50-12:15",@"12:20-12:45",@"12:50-1:15",@"1:20-1:45",@"1:50-2:15"],
                                    @[@"8:45-9:18",@"9:23-9:56",@"10:01-10:34",@"10:39-11:09",@"11:14-11:47",@"11:52-12:25",@"12:30-1:03",@"1:08-1:41",@"1:46-2:20"]];
            
            NSArray *timeLunch2 = @[@[@"7:45-8:40",@"8:45-9:40",@"9:45-10:40",@"10:45-11:20",@"11:25-12:20",@"12:25-1:20",@"1:25-2:20"],
                                    @[@"7:45-8:25",@"8:30-9:10",@"9:15-9:55",@"10:00-10:40",@"10:45-11:15",@"11:20-12:00",@"12:05-12:45",@"12:50-1:30",@"1:35-2:15"],
                                    @[@"7:45-8:20",@"8:25-9:00",@"9:05-9:30",@"9:35-10:10",@"10:15-10:50",@"10:55-11:35",@"11:40-12:15",@"12:20-12:55",@"1:00-1:35",@"1:40-2:15"],
                                    @[@"7:45-8:20",@"8:25-9:00",@"9:05-9:40",@"9:45-10:20",@"10:25-11:35",@"11:40-12:15",@"12:20-12:55",@"1:00-1:35",@"1:40-2:15"],
                                    @[@"9:45-10:10",@"10:15-10:40",@"10:45-11:10",@"11:15-11:40",@"11:45-12:15",@"12:20-12:45",@"12:50-1:15",@"1:20-1:45",@"1:50-2:15"],
                                    @[@"8:45-9:18",@"9:23-9:56",@"10:01-10:34",@"10:39-11:12",@"11:17-11:47",@"11:52-12:25",@"12:30-1:03",@"1:08-1:41",@"1:46-2:20"]];
            
            NSArray *timeLunch3 = @[@[@"7:45-8:40",@"8:45-9:40",@"9:45-10:40",@"10:45-11:40",@"11:45-12:20",@"12:25-1:20",@"1:25-2:20"],
                                    @[@"7:45-8:25",@"8:30-9:10",@"9:15-9:55",@"10:00-10:40",@"10:45-11:15",@"11:20-12:00",@"12:05-12:45",@"12:50-1:30",@"1:35-2:15"],
                                    @[@"7:45-8:20",@"8:25-9:00",@"9:05-9:30",@"9:35-10:10",@"10:15-10:50",@"10:55-11:30",@"11:35-12:15",@"12:20-12:55",@"1:00-1:35",@"1:40-2:15"],
                                    @[@"7:45-8:20",@"8:25-9:00",@"9:05-9:40",@"9:45-10:20",@"10:25-11:35",@"11:40-12:15",@"12:20-12:55",@"1:00-1:35",@"1:40-2:15"],
                                    @[@"9:45-10:10",@"10:15-10:40",@"10:45-11:10",@"11:15-11:40",@"11:45-12:10",@"12:15-12:45",@"12:50-1:15",@"1:20-1:45",@"1:50-2:15"],
                                    @[@"8:45-9:18",@"9:23-9:56",@"10:01-10:34",@"10:39-11:12",@"11:17-11:50",@"11:55-12:25",@"12:30-1:03",@"1:08-1:41",@"1:46-2:20"]];
            
            BOOL cG1 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG1"];
            BOOL cG2 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG2"];
            BOOL cG3 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG3"];
            BOOL cG4 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG4"];
            BOOL cG5 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG5"];
            BOOL cG6 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG6"];
            BOOL cG7 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG7"];
            BOOL cG8 = [[NSUserDefaults standardUserDefaults] boolForKey: @"CG8"];
            
            BOOL  oC1 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC1"];
            BOOL  oC2 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC2"];
            BOOL  oC3 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC3"];
            BOOL  oC4 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC4"];
            BOOL  oC5 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC5"];
            BOOL  oC6 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC6"];
            BOOL  oC7 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC7"];
            BOOL  oC8 = [[NSUserDefaults standardUserDefaults] boolForKey: @"OC8"];
            
            NSArray *gArray = @[@(cG1),@(cG2),@(cG3),@(cG4),@(cG5),@(cG6),@(cG7),@(cG8)];
            NSArray *oArray = @[@(oC1),@(oC2),@(oC3),@(oC4),@(oC5),@(oC6),@(oC7),@(oC8)];
            
            NSString *g1Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 1"];
            NSString *g2Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 2"];
            NSString *g3Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 3"];
            NSString *g4Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 4"];
            NSString *g5Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 5"];
            NSString *g6Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 6"];
            NSString *g7Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 7"];
            NSString *g8Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"gText 8"];
            
            NSString *f1Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 1"];
            NSString *f2Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 2"];
            NSString *f3Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 3"];
            NSString *f4Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 4"];
            NSString *f5Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 5"];
            NSString *f6Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 6"];
            NSString *f7Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 7"];
            NSString *f8Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"fText 8"];
            
            
            NSString *o1Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 1"];
            NSString *o2Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 2"];
            NSString *o3Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 3"];
            NSString *o4Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 4"];
            NSString *o5Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 5"];
            NSString *o6Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 6"];
            NSString *o7Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 7"];
            NSString *o8Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"oText 8"];
            
            NSString *oc1Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 1"];
            NSString *oc2Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 2"];
            NSString *oc3Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 3"];
            NSString *oc4Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 4"];
            NSString *oc5Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 5"];
            NSString *oc6Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 6"];
            NSString *oc7Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 7"];
            NSString *oc8Text = [[NSUserDefaults standardUserDefaults] valueForKey: @"ocText 8"];
            
            NSArray *gTextAr = @[g1Text,g2Text,g3Text,g4Text,g5Text,g6Text,g7Text,g8Text];
            NSMutableArray *gOnTextAr = [[NSMutableArray alloc]init];
            NSMutableArray *gInds = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < gArray.count; i++) {
                if ([gArray[i]  isEqual: @(1)]) {
                    [gOnTextAr addObject:gTextAr[i]];
                    [gInds addObject:@(i)];
                }
            }
            
            NSArray *fTextAr = @[f1Text,f2Text,f3Text,f4Text,f5Text,f6Text,f7Text,f8Text];
            NSMutableArray *fOnTextAr = [[NSMutableArray alloc]init];
            NSMutableArray *fInds = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < gArray.count; i++) {
                if ([gArray[i]  isEqual: @(1)]) {
                    [fOnTextAr addObject:fTextAr[i]];
                    [fInds addObject:@(i)];
                }
            }
            
            NSArray *oTextAr = @[o1Text,o2Text,o3Text,o4Text,o5Text,o6Text,o7Text,o8Text];
            NSMutableArray *oOnTextAr = [[NSMutableArray alloc]init];
            NSMutableArray *oInds = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < oArray.count; i++) {
                if ([oArray[i]  isEqual: @(1)]) {
                    [oOnTextAr addObject:oTextAr[i]];
                    [oInds addObject:@(i)];
                }
            }
            
            NSArray *ocTextAr = @[oc1Text,oc2Text,oc3Text,oc4Text,oc5Text,oc6Text,oc7Text,oc8Text];
            NSMutableArray *ocOnTextAr = [[NSMutableArray alloc]init];
            NSMutableArray *ocInds = [[NSMutableArray alloc]init];
            
            for (int i = 0; i < oArray.count; i++) {
                if ([oArray[i]  isEqual: @(1)]) {
                    [ocOnTextAr addObject:ocTextAr[i]];
                    [ocInds addObject:@(i)];
                }
            }
            
            NSArray *perLunch1 = @[@[c1,c2,@"Lunch",c4,c5,c7,c8],
                                   @[c1,c2,@"Lunch",c3,c6,c7,c8],
                                   @[c2,c3,@"Lunch",c4,c5,c6,c7],
                                   @[c1,c3,@"Lunch",c4,c5,c6,c8],
                                   @[c1,c2,c3,@"Lunch",c4,c5,c6,c7,c8],
                                   @[c1,c2,@"Advisory",c3,@"Lunch",c4,c5,c6,c7,c8],
                                   @[c1,c2,c3,c4,@"Lunch",c5,c6,c7,c8]];
            
            NSArray *perLunch2 = @[@[c1,c2,c4,@"Lunch",c5,c7,c8],
                                   @[c1,c2,c3,@"Lunch",c6,c7,c8],
                                   @[c2,c3,c4,@"Lunch",c5,c6,c7],
                                   @[c1,c3,c4,@"Lunch",c5,c6,c8],
                                   @[c1,c2,c3,c4,@"Lunch",c5,c6,c7,c8],
                                   @[c1,c2,@"Advisory",c3,c4,@"Lunch",c5,c6,c7,c8],
                                   @[c1,c2,c3,c4,@"Lunch",c5,c6,c7,c8]];
            
            NSArray *perLunch3 = @[@[c1,c2,c4,c5,@"Lunch",c7,c8],
                                   @[c1,c2,c3,c6,@"Lunch",c7,c8],
                                   @[c2,c3,c4,c5,@"Lunch",c6,c7],
                                   @[c1,c3,c4,c5,@"Lunch",c6,c8],
                                   @[c1,c2,c3,c4,c5,@"Lunch",c6,c7,c8],
                                   @[c1,c2,@"Advisory",c3,c4,c5,@"Lunch",c6,c7,c8],
                                   @[c1,c2,c3,c4,@"Lunch",c5,c6,c7,c8]];
            
            if ([day isEqualToString:@"none"]) {
                self.title = @"No School Today";
            }
            
            BOOL lunchEvery = [[NSUserDefaults standardUserDefaults] boolForKey: @"lEvery"];
            
            if (![day isEqualToString:@"special"] && ![day isEqualToString:@"none"]) {
                NSArray *timeLunch;
                NSArray *perLunch;
                if (lunchEvery) {
                    switch (lunch) {
                        case 1:
                            timeLunch = timeLunch1;
                            perLunch = perLunch1;
                            break;
                        case 2:
                            timeLunch = timeLunch2;
                            perLunch = perLunch2;
                            break;
                        case 3:
                            timeLunch = timeLunch3;
                            perLunch = perLunch3;
                            break;
                        default:
                            break;
                    }
                }else{
                    [self splitLunches];
                    for (NSString *s1 in lunchE1) {
                        if ([day isEqualToString:s1.uppercaseString]) {
                            timeLunch = timeLunch1;
                            perLunch = perLunch1;
                            break;
                        }
                    }
                    
                    for (NSString *s2 in lunchE2) {
                        if ([day isEqualToString:s2.uppercaseString]) {
                            timeLunch = timeLunch2;
                            perLunch = perLunch2;
                            break;
                        }
                    }
                    
                    for (NSString *s3 in lunchE3) {
                        if ([day isEqualToString:s3.uppercaseString]) {
                            timeLunch = timeLunch3;
                            perLunch = perLunch3;
                            break;
                        }
                    }
                }
                
                if ([day isEqualToString:@"Adv"]) {
                    _sched = timeLunch[2];
                }else if ([day isEqualToString:@"Col"]) {
                    _sched = timeLunch[3];
                }else if ([day isEqualToString:@"2HD"]) {
                    _sched = timeLunch[4];
                }else if ([day isEqualToString:@"1HD"]) {
                    _sched = timeLunch[5];
                }else{
                    _sched = ([day isEqualToString:@"5"]||[day isEqualToString:@"E"]) ? timeLunch[1] : timeLunch[0];
                }
                
                self.title = [NSString stringWithFormat:@"Date:%@ Day: %@",dateString, [day capitalizedString]];
                
                NSArray *days = @[@"A",@"B",@"C",@"D",@"E",@"1",@"2",@"3",@"4",@"5",@"Weekend",@"Adv",@"Col",@"1HD",@"2HD"];
                
                if ([day isEqualToString:@"Adv"]) {
                    self.title = @"Advisory";
                }else if ([day isEqualToString:@"Col"]){
                    self.title = @"Collaborative";
                }else if ([day isEqualToString:@"1HD"]){
                    self.title = @"One-Hour Delay";
                }else if ([day isEqualToString:@"2HD"]){
                    self.title = @"Two-Hour Delay";
                }
                
                for (int i = 0; i < days.count; i++) {
                    if ([day isEqualToString:days[i]]) {
                        switch (i) {
                            case 0:
                            case 5:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[0]];
                                break;
                            case 1:
                            case 6:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[1]];
                                break;
                            case 2:
                            case 7:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[2]];
                                break;
                            case 3:
                            case 8:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[3]];
                                break;
                            case 4:
                            case 9:
                            case 10:
                            case 13:
                            case 14:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[4]];
                                break;
                            case 11:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[5]];
                                break;
                            case 12:
                                _period = [[NSMutableArray alloc] initWithArray:perLunch[6]];
                                break;
                                break;
                                
                        }
                    }
                }
                
                if ([day isEqualToString:@"Adv"] || [day isEqualToString:@"Col"]) {
                    day = advColString;
                }
                
                if ([day isEqualToString:@"2HD"] || [day isEqualToString:@"1HD"]) {
                    NSCharacterSet* notDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
                    if ([[dayList objectForKey:dateString] rangeOfCharacterFromSet:notDigits].location == NSNotFound)
                    {
                        day = @"5";
                    }else {
                        day = @"E";
                    }
                }
                
                NSArray *cArray = @[c1,c2,c3,c4,c5,c6,c7,c8];
                int gx = 0;
                for (NSString *g in gOnTextAr) {
                    if (![g isEqualToString:@""]) {
                        int gIndex = (int)[gInds[gx] integerValue];
                        
                        NSMutableArray *gTextSplitArr = [[NSMutableArray alloc] init];
                        
                        for (int x = 0; x < g.length; x++) {
                            [gTextSplitArr addObject:[NSString stringWithFormat:@"%c",[g characterAtIndex:x]]];
                        }
                        
                        for (NSString *s in gTextSplitArr) {
                            if ([day isEqualToString:s.uppercaseString]) {
                                NSString *course = [cArray objectAtIndex:gIndex];
                                int cInd = (int)[_period indexOfObject:course];
                                @try {
                                    [_period replaceObjectAtIndex:cInd withObject:@"Gym"];
                                }
                                @catch (NSException *e) {
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Course Selection" message:[NSString stringWithFormat:@"The course %@ does not occur on this day.",course] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
                                    alert.tag = 0;
                                    [alert show];
                                    return;
                                }
                                
                                break;
                            }
                        }
                    }
                    gx++;
                }
                int fx = 0;
                for (NSString *f in fOnTextAr) {
                    if (![f isEqualToString:@""]) {
                        int fIndex = (int)[fInds[fx] integerValue];
                        
                        NSMutableArray *fTextSplitArr = [[NSMutableArray alloc] init];
                        
                        for (int x = 0; x < f.length; x++) {
                            [fTextSplitArr addObject:[NSString stringWithFormat:@"%c",[f characterAtIndex:x]]];
                        }
                        
                        for (NSString *s in fTextSplitArr) {
                            if ([day isEqualToString:s.uppercaseString]) {
                                NSString *course = [cArray objectAtIndex:fIndex];
                                int cInd = (int)[_period indexOfObject:course];
                                
                                @try {
                                    [_period replaceObjectAtIndex:cInd withObject:@"Free"];
                                }
                                @catch (NSException *e) {
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Course Selection" message:[NSString stringWithFormat:@"The course %@ does not occur on this day.",course] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
                                    alert.tag = 1;
                                    [alert show];
                                    return;
                                }
                                
                                break;
                            }
                        }
                    }
                    fx++;
                }
                
                int ocx = 0;
                for (NSString *oc in ocOnTextAr) {
                    if (![oc isEqualToString:@""]) {
                        int ocIndex = (int)[ocInds[ocx] integerValue];
                        
                        NSMutableArray *ocTextSplitArr = [[NSMutableArray alloc] init];
                        
                        for (int x = 0; x < oc.length; x++) {
                            [ocTextSplitArr addObject:[NSString stringWithFormat:@"%c",[oc characterAtIndex:x]]];
                        }
                        
                        for (NSString *s in ocTextSplitArr) {
                            if ([day isEqualToString:s.uppercaseString]) {
                                NSString *course = [cArray objectAtIndex:ocIndex];
                                int cInd = (int)[_period indexOfObject:course];
                                
                                @try {
                                    [_period replaceObjectAtIndex:cInd withObject:[oTextAr objectAtIndex:ocIndex]];
                                }
                                @catch (NSException *e) {
                                    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error in Course Selection" message:[NSString stringWithFormat:@"The course %@ does not occur on this day.",course] delegate:self cancelButtonTitle:nil otherButtonTitles:@"Continue", nil];
                                    alert.tag = 2;
                                    [alert show];
                                    return;
                                }
                                
                                break;
                            }
                        }
                    }
                    ocx++;
                }
                
            } else if ([day isEqualToString:@"special"]){
                
                PFQuery *query = [PFQuery queryWithClassName:@"Schedule"];
                [query whereKey:@"Name" equalTo:@"Day"];
                PFObject *object = [query getFirstObject];
                if (![object[@"Time"] isEqualToString:@"Normal"]) {
                    self.title = object[@"Time"];
                }
                
                [query cancel];
                query = NULL;
                
                PFQuery *query2 = [PFQuery queryWithClassName:@"Schedule"];
                [query2 whereKey:@"Order" greaterThan:@0];
                int amt = (int)[query2 countObjects];
                
                [query2 cancel];
                query2 = NULL;
                
                NSMutableArray *specialPer = [[NSMutableArray alloc]initWithCapacity:amt];
                NSMutableArray *specialSched = [[NSMutableArray alloc]initWithCapacity:amt];
                
                for (int i = 0; i < amt; i++) {
                    [specialPer addObject:@(0)];
                    [specialSched addObject:@(0)];
                }
                
                PFQuery *query3 = [PFQuery queryWithClassName:@"Schedule"];
                [query3 whereKey:@"Name" equalTo:@"Course 1"];
                PFObject *c1Obj = [query3 getFirstObject];
                int c1Ind = [[c1Obj objectForKey:@"Order"] intValue];
                if (c1Ind != -1) {
                    specialPer[c1Ind-1] = c1;
                    specialSched[c1Ind-1] = c1Obj[@"Time"];
                }
                
                [query3 cancel];
                query3 = NULL;
                
                PFQuery *query4 = [PFQuery queryWithClassName:@"Schedule"];
                [query4 whereKey:@"Name" equalTo:@"Course 2"];
                PFObject *c2Obj = [query4 getFirstObject];
                int c2Ind = [[c2Obj objectForKey:@"Order"] intValue];
                if (c2Ind != -1) {
                    specialPer[c2Ind-1] = c2;
                    specialSched[c2Ind-1] = c2Obj[@"Time"];
                }
                
                [query4 cancel];
                query4 = NULL;
                
                PFQuery *query5 = [PFQuery queryWithClassName:@"Schedule"];
                [query5 whereKey:@"Name" equalTo:@"Course 3"];
                PFObject *c3Obj = [query5 getFirstObject];
                int c3Ind = [[c3Obj objectForKey:@"Order"] intValue];
                if (c3Ind != -1) {
                    specialPer[c3Ind-1] = c3;
                    specialSched[c3Ind-1] = c3Obj[@"Time"];
                }
                
                [query5 cancel];
                query5 = NULL;
                
                PFQuery *query6 = [PFQuery queryWithClassName:@"Schedule"];
                [query6 whereKey:@"Name" equalTo:@"Course 4"];
                PFObject *c4Obj = [query6 getFirstObject];
                int c4Ind = [[c4Obj objectForKey:@"Order"] intValue];
                if (c4Ind != -1) {
                    specialPer[c4Ind-1] = c4;
                    specialSched[c4Ind-1] = c4Obj[@"Time"];
                }
                
                [query6 cancel];
                query6 = NULL;
                
                PFQuery *query7 = [PFQuery queryWithClassName:@"Schedule"];
                [query7 whereKey:@"Name" equalTo:@"Course 5"];
                PFObject *c5Obj = [query7 getFirstObject];
                int c5Ind = [[c5Obj objectForKey:@"Order"] intValue];
                if (c5Ind != -1) {
                    specialPer[c5Ind-1] = c5;
                    specialSched[c5Ind-1] = c5Obj[@"Time"];
                }
                
                [query7 cancel];
                query7 = NULL;
                
                PFQuery *query8 = [PFQuery queryWithClassName:@"Schedule"];
                [query8 whereKey:@"Name" equalTo:@"Course 6"];
                PFObject *c6Obj = [query8 getFirstObject];
                int c6Ind = [[c6Obj objectForKey:@"Order"] intValue];
                if (c6Ind != -1) {
                    specialPer[c6Ind-1] = c6;
                    specialSched[c6Ind-1] = c6Obj[@"Time"];
                }
                
                [query8 cancel];
                query8 = NULL;
                
                PFQuery *query9 = [PFQuery queryWithClassName:@"Schedule"];
                [query9 whereKey:@"Name" equalTo:@"Course 7"];
                PFObject *c7Obj = [query9 getFirstObject];
                int c7Ind = [[c7Obj objectForKey:@"Order"] intValue];
                if (c7Ind != -1) {
                    specialPer[c7Ind-1] = c7;
                    specialSched[c7Ind-1] = c7Obj[@"Time"];
                }
                
                [query9 cancel];
                query9 = NULL;
                
                PFQuery *query10 = [PFQuery queryWithClassName:@"Schedule"];
                [query10 whereKey:@"Name" equalTo:@"Course 8"];
                PFObject *c8Obj = [query10 getFirstObject];
                int c8Ind = [[c8Obj objectForKey:@"Order"] intValue];
                if (c8Ind != -1) {
                    specialPer[c8Ind-1] = c8;
                    specialSched[c8Ind-1] = c8Obj[@"Time"];
                }
                
                [query10 cancel];
                query10 = NULL;
                
                PFQuery *query11 = [PFQuery queryWithClassName:@"Schedule"];
                [query11 whereKey:@"Type" equalTo:@"Special1"];
                PFObject *c9Obj = [query11 getFirstObject];
                int c9Ind = [[c9Obj objectForKey:@"Order"] intValue];
                if (c9Ind != -1) {
                    specialPer[c9Ind-1] = c9Obj[@"Name"];
                    specialSched[c9Ind-1] = c9Obj[@"Time"];
                }
                
                [query11 cancel];
                query11 = NULL;
                
                PFQuery *query12 = [PFQuery queryWithClassName:@"Schedule"];
                [query12 whereKey:@"Type" equalTo:@"Special2"];
                PFObject *c10Obj = [query12 getFirstObject];
                int c10Ind = [[c10Obj objectForKey:@"Order"] intValue];
                if (c10Ind != -1) {
                    specialPer[c10Ind-1] = c10Obj[@"Name"];
                    specialSched[c10Ind-1] = c10Obj[@"Time"];
                }
                
                [query12 cancel];
                query12 = NULL;
                
                PFQuery *query13 = [PFQuery queryWithClassName:@"Schedule"];
                [query13 whereKey:@"Type" equalTo:@"Special3"];
                PFObject *c11Obj = [query13 getFirstObject];
                int c11Ind = [[c11Obj objectForKey:@"Order"] intValue];
                if (c11Ind != -1) {
                    specialPer[c11Ind-1] = c11Obj[@"Name"];
                    specialSched[c11Ind-1] = c11Obj[@"Time"];
                }
                
                [query13 cancel];
                query13 = NULL;
                
                PFQuery *query14 = [PFQuery queryWithClassName:@"Schedule"];
                [query14 whereKey:@"Type" equalTo:@"Special4"];
                PFObject *c12Obj = [query14 getFirstObject];
                int c12Ind = [[c12Obj objectForKey:@"Order"] intValue];
                if (c12Ind != -1) {
                    specialPer[c12Ind-1] = c12Obj[@"Name"];
                    specialSched[c12Ind-1] = c12Obj[@"Time"];
                }
                
                [query14 cancel];
                query14 = NULL;
                
                PFQuery *query15 = [PFQuery queryWithClassName:@"Schedule"];
                [query15 whereKey:@"Name" equalTo:@"Lunch"];
                PFObject *c13Obj = [query15 getFirstObject];
                int c13Ind = [[c13Obj objectForKey:@"Order"] intValue];
                if (c13Ind != -1) {
                    specialPer[c13Ind-1] = @"Lunch";
                    specialSched[c13Ind-1] = c13Obj[@"Time"];
                }
                
                [query15 cancel];
                query15 = NULL;
                
                _period = specialPer;
                _sched = specialSched;
                
                [self.tableView reloadData];
            }
            [self.tableView reloadData];
            //[self highlightCourse];
            
            
        }];
        
        
     /*   dayList = @{@"04/06":@"A",@"04/07":@"B",@"04/08":@"C",@"04/09":@"D",@"04/10":@"E",@"04/11":@"Weekend",@"04/12":@"Weekend",@"04/13":@"1",@"04/14":@"2",@"04/15":@"3",@"04/16":@"special",@"04/17":@"4",@"04/18":@"Weekend",@"04/19":@"Weekend",@"04/20":@"A",@"04/21":@"B",@"04/22":@"C",@"04/23":@"D",@"04/24":@"Col",@"04/25":@"Weekend",@"04/26":@"Weekend",@"04/27":@"1",@"04/28":@"2",@"04/29":@"3",@"04/30":@"4",@"05/01":@"5",@"05/02":@"Weekend",@"05/03":@"Weekend",@"05/04":@"A",@"05/05":@"B",@"05/06":@"C",@"05/07":@"D",@"05/08":@"Adv",@"05/09":@"Weekend",@"05/10":@"Weekend",@"05/11":@"1",@"05/12":@"2",@"05/13":@"3",@"05/14":@"4",@"05/15":@"5",@"05/16":@"Weekend",@"05/17":@"Weekend",@"05/18":@"A",@"05/19":@"B",@"05/20":@"C",@"05/21":@"D",@"05/22":@"Col",@"05/23":@"Weekend",@"05/24":@"Weekend",@"05/25":@"none",@"05/26":@"1",@"05/27":@"2",@"05/28":@"3",@"05/29":@"4",@"05/30":@"Weekend",@"05/31":@"Weekend",@"06/01":@"A",@"06/02":@"B",@"06/03":@"C",@"06/04":@"D",@"06/05":@"Adv",@"06/06":@"Weekend",@"06/07":@"Weekend",@"06/08":@"5",@"06/09":@"E",@"06/10":@"5"};
        NSDictionary *advColList = @{@"04/24":@"E",@"05/08":@"E",@"05/22":@"E",@"06/05":@"E"};
        
        if (![day isEqualToString:@"1HD"] && ![day isEqualToString:@"2HD"]) {
            day = [dayList objectForKey:dateString];
        }
        
        NSString * dayS = [[NSUserDefaults standardUserDefaults]stringForKey:@"mainDate"];
        if (![dayS isEqualToString:@"Normal"]) {
                day = dayS;
        }
        
        if ([advColList objectForKey:dateString] != NULL) {
            advColString = [advColList objectForKey:dateString];
        }*/
    }
    
    
}
                                                  
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 0)
    {
        [self goToInfo];
    }
    if(alertView.tag == 1)
    {
        [self goToInfo];
    }
    if(alertView.tag == 2)
    {
        [self goToInfo];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_sched count];
}

-(void) setFinal{
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.flhsCS.ScheduleTodayDefaults"];
    [defaults setObject:courseFinal forKey:@"courseArray"];
    [defaults synchronize];
    [defaults setObject:timeFinal forKey:@"timeArray"];
    [defaults synchronize];
    [defaults setValue:day forKey:@"finalDay"];
    [defaults synchronize];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    long num = indexPath.row;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.detailTextLabel.text = [_sched objectAtIndex:indexPath.row];
    cell.textLabel.text = [_period objectAtIndex:indexPath.row];
    
    
    /*if ([indexPath isEqual:[NSIndexPath indexPathForRow:currentCourse inSection:0]]) {
        
        UIView *bgColorView = [[UIView alloc] init];
        bgColorView.backgroundColor = [UIColor colorWithRed:(76.0/255.0) green:(161.0/255.0) blue:(255.0/255.0) alpha:1.0];
        bgColorView.layer.masksToBounds = YES;
        cell.selectedBackgroundView = bgColorView;
        
        [tableView selectRowAtIndexPath:indexPath
                               animated:YES
                         scrollPosition:UITableViewScrollPositionNone];
    }else{
        cell.userInteractionEnabled = NO;
    }*/
    
    cell.userInteractionEnabled = NO;
    
    [timeFinal addObject:[_sched objectAtIndex:indexPath.row]];
    [courseFinal addObject:[_period objectAtIndex:indexPath.row]];
    
    if (num == _period.count - 1) {
        [self setFinal];
    }
    
    return cell;
}

@end
