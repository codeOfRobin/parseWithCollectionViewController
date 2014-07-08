//
//  ViewController.m
//  parseWithCollectionViewController
//
//  Created by Robin Malhotra on 18/06/14.
//  Copyright (c) 2014 Robin's code kitchen. All rights reserved.
//

#import "ViewController.h"
#import <Parse/Parse.h>
@interface ViewController ()
@property UIRefreshControl *refreshControl;
@property NSMutableArray *objs;
@end

@implementation ViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
        
        [self.collectionView reloadData];
    }];
    
    
}

    
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self performSelector:@selector(retrieveFromParse)];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView reloadData];
    
    UIRefreshControl *refresh=[[UIRefreshControl alloc] init];
    [refresh setAttributedTitle:[[NSAttributedString alloc]initWithString:@"pull to refresh"]];
    [refresh addTarget:self action:@selector(refreshData) forControlEvents:UIControlEventValueChanged];
    [self.collectionView addSubview:refresh];
    self.collectionView.alwaysBounceVertical = YES;
    self.refreshControl=refresh;

    // Do any additional setup after loading the view.
}

-(void)refreshData
{
    PFObject *tempObject = [self.objs objectAtIndex:5];
    NSLog(@"%@",[tempObject objectForKey:@"Date"]);
    [self performSelector:@selector(updateTable) withObject:nil afterDelay:5];
    
}


-(void)updateTable
{
    [self.collectionView reloadData];
    [self.refreshControl endRefreshing];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.objs count];
}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    PFObject *tempObject = [self.objs objectAtIndex:indexPath.row];

    UILabel *label=[cell viewWithTag:1];
    [label setText:[tempObject objectForKey:@"name"]];
    
    return cell;
    
}


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
