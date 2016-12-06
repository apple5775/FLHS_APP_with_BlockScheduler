//
//  TodayViewController.m
//  TodaySchedule
//
//  Created by Jacob Rauch on 2/22/15.
//  Copyright (c) 2015 Jacob Rauch. All rights reserved.
//

#import "TodayViewController.h"
#import <NotificationCenter/NotificationCenter.h>

@interface TodayViewController () <NCWidgetProviding, UITableViewDataSource, UITableViewDelegate> {
    NSMutableArray *time;
    NSMutableArray *course;
    NSString *day;
    IBOutlet UIScrollView *scrollV;
}
@property (weak, nonatomic) IBOutlet UITableView *table1;

@end

@implementation TodayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *defaults = [[NSUserDefaults alloc] initWithSuiteName:@"group.flhsCS.ScheduleTodayDefaults"];
    
    course = [defaults objectForKey:@"courseArray"];
    time = [defaults objectForKey:@"timeArray"];
    day = [defaults stringForKey:@"finalDay"];
    
    self.preferredContentSize = CGSizeMake(self.preferredContentSize.width, (course.count + .5) * 44.0);
    
    scrollV.contentSize =  CGSizeMake(self.preferredContentSize.width, (course.count + .5) * 44.0);

}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    completionHandler(NCUpdateResultNewData);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [course count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
   return [NSString stringWithFormat:@"Day: %@",day];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.detailTextLabel.textColor = [UIColor whiteColor];
    
    cell.detailTextLabel.text = [time objectAtIndex:indexPath.row];
    cell.textLabel.text = [course objectAtIndex:indexPath.row];
    
    cell.selectionStyle = NO;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
