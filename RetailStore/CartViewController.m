//
//  CartViewController.m
//  RetailStore
//
//  Created by Preetam Jadakar on 09/07/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import "CartViewController.h"
#import "Product.h"
@interface CartViewController ()
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;
@property (nonatomic,retain)NSArray *cartData;
@property (weak, nonatomic) IBOutlet UILabel *emptyListMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *priceView;

@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cartTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.cartTableView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.cartData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // init the cell
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    

    return cell;
    
}

@end
