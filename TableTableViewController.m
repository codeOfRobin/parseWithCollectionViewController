//
//  TableTableViewController.m
//  parseWithCollectionViewController
//
//  Created by Robin Malhotra on 15/06/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "TableTableViewController.h"

@interface TableTableViewController ()
@property NSMutableArray *objs;
@end

@implementation TableTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }

    return self;
}

-(void)retrieveFromParse
{
    PFQuery *retrieveEvents=[PFQuery queryWithClassName:@"events"];
    [retrieveEvents findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error)
        {
            self.objs=[[NSMutableArray alloc] initWithArray:objects];
        }
        [self.tableView reloadData];

    }];
    

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(retrieveFromParse)];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.tableView reloadData];
    
    UIRefreshControl *refresh=[[UIRefreshControl alloc] init];
    [refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:@"pull to refresh"]];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    self.refreshControl=refresh;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)refreshData
{
    PFObject *tempObject = [self.objs objectAtIndex:5];
    NSLog(@"%@",[tempObject objectForKey:@"Date"]);
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:5];

}

-(void)updateTable
{
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
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
    return [self.objs count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject *tempObject = [self.objs objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [tempObject objectForKey:@"name"];
    // Configure the cell...
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
