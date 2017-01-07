//
//  InputCourseViewController.m
//  TableViewTry2
//
//  Created by Brian Poor on 1/4/17.
//  Copyright © 2017 Brian Poor. All rights reserved.
//

#import "InputCourseViewController.h"
#import "DayViewController.h"

@interface InputCourseViewController (){
    NSMutableArray* tableData;
}

@end

@implementation InputCourseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tableData = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableData removeObjectAtIndex:indexPath.row];
    [tableView reloadData];
}

- (IBAction)addCourseButtonClick:(id)sender {
    NSString *repo = self.courseTextField.text;
    self.courseTextField.text = @"";
    [self.courseTextField resignFirstResponder];
    [tableData addObject:repo]; //repository is a NSMutableArray
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:[tableData indexOfObject:repo] inSection:0];
    [self.courseTableView beginUpdates];
    [self.courseTableView
     insertRowsAtIndexPaths:@[indexPath]withRowAnimation:UITableViewRowAnimationBottom];
    [self.courseTableView endUpdates];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.courseTextField resignFirstResponder];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString: @"courseDataSegue"]) {
        DayViewController * destinationVC = segue.destinationViewController;
        LunchConnector *connectorClass = [[LunchConnector alloc] init];
        connectorClass.courseArrayBeingPassed = tableData;
        destinationVC.connectorClass = connectorClass;
    }
}
- (IBAction)doneButtonClick:(id)sender {
    [self performSegueWithIdentifier:@"courseDataSegue" sender:self];
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
