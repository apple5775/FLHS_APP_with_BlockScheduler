//
//  jvTableViewController.m
//  FLHS_App
//
//  Created by Jacob Rauch on 3/18/14.
//  Copyright (c) 2014 Jacob Rauch. All rights reserved.
//

#import "jvTableViewController.h"

@interface jvTableViewController ()

@end

@implementation jvTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    switch (section) {
        case 0:
            return 4;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 5;
            break;
            
        default:
            return 0;
            break;
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSArray *fall =[NSArray arrayWithObjects:@"Field Hockey",@"Football",@"Soccer: Boys",@"Soccer: Girls", nil];
    NSArray *winter = [NSArray arrayWithObjects:@"Basketball: Boys",@"Basketball: Girls", nil];
    NSArray *spring = [NSArray arrayWithObjects:@"Baseball: Freshmen",@"Baseball: JV",@"Laccrosse: Boys",@"Lacrosse: Girls",@"Softball", nil];

    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0:
            cell.textLabel.text = [fall objectAtIndex:indexPath.row];
            break;
        case 1:
            cell.textLabel.text = [winter objectAtIndex:indexPath.row];
            break;
        case 2:
            cell.textLabel.text = [spring objectAtIndex:indexPath.row];
            break;
        default:
            
            break;
    }
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.section) {
        case 0:
            break;
        case 1:
            break;
        case 2:
            break;
        default:
            break;
    }
}


@end
