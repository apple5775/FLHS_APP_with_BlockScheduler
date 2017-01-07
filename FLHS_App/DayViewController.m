//
//  DayViewController.m
//  TableViewTry2
//
//  Created by Brian Poor on 1/5/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "DayViewController.h"
#import "SWRevealViewController.h"
#import <Parse/Parse.h>

@interface DayViewController (){
    NSMutableArray* timeData;
    NSMutableArray* tableData;
    int dayValue;
    NSArray *dayArray;
}

@end

@implementation DayViewController

@synthesize connectorClass;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    
    
    dayValue = 0;
    dayArray = @[@"Day A",@"Day B",@"Day C",@"Day D",@"Day E",@"Day 1",@"Day 2",@"Day 3",@"Day 4",@"Day 5"];
    [self refreshViewController];
    // Do any additional setup after loading the view.
    
}
-(void) refreshCourses{
    
}

-(void) refreshViewController{
    self.lunchData = connectorClass.lunchArrayBeingPassed;
    self.courseData = connectorClass.courseArrayBeingPassed;
    
    //[self retreiveValuesParseAndSetLocalVar];
    
    NSLog(@"CourseDataFirstValue%@", self.courseData[0]);
    NSLog(@"LunchData");
    
    tableData = [[NSMutableArray alloc]init];
    
    int tempNumTableData = 6;
    if(dayValue == 4 || dayValue == 9){
        tempNumTableData = 8;
    }
    for (int i = 0; i <= tempNumTableData; i++){
        [tableData addObject:@"Set Course and Lunch"];
    }
    
    NSLog(@"dayValue %ld", (long)dayValue);
    NSLog(@"lunchType %@", self.lunchData[dayValue]);
    if (dayValue != 4 && dayValue != 9){
        if ([self.lunchData[dayValue] isEqualToString: @"Early"]){
            NSArray * eReg = @[@"7:45-8:40", @"8:45-9:40", @"9:45-10:20", @"10:25-11:20", @"11:25-12:20", @"12:25-1:20", @"1:25-2:20"];
            timeData = [[NSMutableArray alloc]init];
            [timeData addObjectsFromArray:eReg];
            NSLog(@"WHY %@",timeData[1]);
            tableData[2] = @"Lunch";
        } else if ([self.lunchData[dayValue] isEqualToString: @"Middle"]){
            NSArray * mReg = @[@"7:45-8:40", @"8:45-9:40", @"9:45-10:40", @"10:45-11:20", @"11:25-12:20", @"12:25-1:20", @"1:25-2:20"];
            timeData = [[NSMutableArray alloc]init];
            [timeData addObjectsFromArray:mReg];
            NSLog(@"%@",timeData[1]);
            tableData[3] = @"Lunch";
        } else if ([self.lunchData[dayValue] isEqualToString: @"Late"]){
            NSArray * lReg = @[@"7:45-8:40", @"8:45-9:40", @"9:45-10:40", @"10:45-11:40", @"11:45-12:20", @"12:25-1:20", @"1:25-2:20"];
            timeData = [[NSMutableArray alloc]init];
            [timeData addObjectsFromArray:lReg];
            NSLog(@"%@",timeData[1]);
            tableData[4] = @"Lunch";
        }
    }else{
        NSLog(@"I AM HERE");
        if ([self.lunchData[dayValue] isEqualToString: @"Early"]){
            NSLog(@"BLAH");
            timeData = [[NSMutableArray alloc]init];
            NSArray * eSpe = @[@"7:45-8:25", @"8:30-9:10", @"9:15-9:55", @"10:00-10:30", @"10:35-11:15", @"11:20-12:00", @"12:05-12:45", @"12:50-1:30",@"1:35-2:15"];
            [timeData addObjectsFromArray:eSpe];
            tableData[3] = @"Lunch";
        } else if ([self.lunchData[dayValue] isEqualToString: @"Middle"]){
            NSLog(@"BLAH BLAH");
            timeData = [[NSMutableArray alloc]init];
            NSArray * mSpe = @[@"7:45-8:25", @"8:30-9:10", @"9:15-9:55", @"10:00-10:40", @"10:45-11:15", @"11:20-12:00", @"12:05-12:45", @"12:50-1:30",@"1:35-2:15"];
            [timeData addObjectsFromArray:mSpe];
            tableData[4] = @"Lunch";
        } else if ([self.lunchData[dayValue] isEqualToString: @"Late"]){
            NSLog(@"BLAH BLAH BLAH");
            timeData = [[NSMutableArray alloc]init];
            NSArray * lSpe = @[@"7:45-8:25", @"8:30-9:10", @"9:15-9:55", @"10:00-10:40", @"10:45-11:25", @"11:30-12:00", @"12:05-12:45", @"12:50-1:30",@"1:35-2:15"];
            [timeData addObjectsFromArray:lSpe];
            tableData[5] = @"Lunch";
        }
    }
    
    [self.scheduleTableView reloadData];
}

- (void) pushParse{
    PFObject *gameScore = [PFObject objectWithClassName:@"ScheduleBrian"];
    gameScore[@"lunchData"] = [self.lunchData componentsJoinedByString:@",::"];
    gameScore[@"courseData"] = @"Sean Plott";
    gameScore[@"scheduleData"] = @"test";
    [gameScore saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // The object has been saved.
            NSLog(@"YAY YAY YAY");
        } else {
            // There was a problem, check error.description
            NSLog(@"NO NO NO");
        }
    }];
}
- (void) updateParse{
    PFQuery *query = [PFQuery queryWithClassName:@"ScheduleBrian"];
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"xWMyZ4YEGZ"
                                 block:^(PFObject *ScheduleBrian, NSError *error) {
    // Now let's update it with some new data. In this case, only cheatMode and score
    // will get sent to the cloud. playerName hasn't changed.
    ScheduleBrian[@"cheatMode"] = @YES;
    ScheduleBrian[@"score"] = @1338;
    [ScheduleBrian saveInBackground];
    }];
}

- (void) retreiveValuesParseAndSetLocalVar{
    PFQuery *query = [PFQuery queryWithClassName:@"ScheduleBrian"];
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:@"OXEZI1u1wT"
                                 block:^(PFObject *ScheduleBrian, NSError *error) {
                                     self.lunchData = nil;
                                     NSString *temp = ScheduleBrian[@"lunchData"];
                                     NSArray *tempArray = [temp componentsSeparatedByString:@",::"];
                                     self.lunchData = [[NSMutableArray alloc]init];
                                     [self.lunchData addObjectsFromArray:tempArray];
                                     NSLog(@"lunchDataAfterQuery %@", self.lunchData[0]);
                                 }];
         
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [tableData count];
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    if (indexPath.row <= 9){
        cell.textLabel.text = [timeData objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [tableData objectAtIndex:indexPath.row];
    }
    return cell;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if([self.courseData count] == 0){
        UIAlertController* courseAlert = [UIAlertController alertControllerWithTitle:@"No Courses Given"
                                                                             message:@"Please Input Courses"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* defaultAction= [UIAlertAction actionWithTitle:@"Close" style:UIAlertActionStyleDefault
                                                                                handler:^(UIAlertAction * action) {}];
        [courseAlert addAction:defaultAction];
        
        [self presentViewController:courseAlert animated:YES completion:nil];
        
        
    } else{
        UIAlertController* courseAlert = [UIAlertController alertControllerWithTitle:@"Courses"
                                                                             message:@"Select Course"
                                                                      preferredStyle:UIAlertControllerStyleAlert];
        
        NSMutableArray * choices = [[NSMutableArray alloc]init];

        NSLog(@"%lu",(unsigned long)[self.courseData count]);
    
        for (int i = 0; i <= [self.courseData count] - 1; i++){
            [choices addObject: [UIAlertAction actionWithTitle:self.courseData[i] style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {tableData[indexPath.row] = self.courseData[i];[self.scheduleTableView reloadData];}]];
            [courseAlert addAction:choices[i]];
        }
    
        [self presentViewController:courseAlert animated:YES completion:nil];
    }

}
- (IBAction)dayButtonClick:(id)sender {
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Day"
                                                                   message:@"Select Day"
                                                            preferredStyle:UIAlertControllerStyleAlert];
    NSMutableArray * choices = [[NSMutableArray alloc]init];
    
    for (int i = 0; i <= 9; i++){
        [choices addObject: [UIAlertAction actionWithTitle:dayArray[i] style:UIAlertActionStyleDefault
                                                                                handler:^(UIAlertAction * action) {[self.dayButton setTitle:dayArray[i] forState:UIControlStateNormal]; dayValue = i; [self refreshViewController];}]];
        [alert addAction:choices[i]];
    }
    
    [self presentViewController:alert animated:YES completion:nil];
    
    
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
