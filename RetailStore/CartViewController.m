//
//  CartViewController.m
//  RetailStore
//
//  Created by Preetam Jadakar on 09/07/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import "CartViewController.h"
#import "Product.h"
#import "AppDelegate.h"
#define kCartCellID @"cartCellId"

@interface CartViewController ()
@property (weak, nonatomic) IBOutlet UITableView *cartTableView;
@property (nonatomic,retain)NSArray *cartData;
@property (weak, nonatomic) IBOutlet UILabel *emptyListMessageLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UIView *priceView;
@property(retain)NSString *currentPhoneNumber;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.cartTableView setTableFooterView:[[UIView alloc]initWithFrame:CGRectZero]];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self refreshView];
}
-(void)refreshView{
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    if (appDel.cartDataArray.count) {
        self.emptyListMessageLabel.hidden = YES;
        self.priceView.hidden = NO;
        
    }
    else{
        self.emptyListMessageLabel.hidden = NO;
        self.priceView.hidden = YES;
        
    }
    NSNumber *sum = @0;
    
    for (Product *pr in appDel.cartDataArray) {
        sum  = @([sum floatValue] + [pr.productPrice floatValue]);
    }
    self.totalPriceLabel.text = [NSString stringWithFormat:@"Total: %@",sum];
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
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    return appDel.cartDataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    
    // init the cell
    
    CartCell *cell = [tableView dequeueReusableCellWithIdentifier:kCartCellID];
    
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"CartCell" owner:self options:nil];
        // Grab a pointer to the first object (presumably the custom cell, as that's all the XIB should contain).
        cell = [topLevelObjects objectAtIndex:0];
        cell.delegate = self;
    }
    
    Product *product = [appDel.cartDataArray objectAtIndex:indexPath.row];
    
    
    cell.productName.text = product.productName;
    cell.priceLabel.text = [NSString stringWithFormat:@"Price:\n%@",product.productPrice];
    cell.vNameLabel.text = product.venderName;
    cell.vAddLabel.text= product.venderAddress;
    //    cell.productImage.image = [UIImage ima]
    
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 121;
}
#pragma  mark - CartCell Delegates
-(void)removeCartItemFromCell:(CartCell *)cell
{
    
    NSIndexPath *selectedIndexPath = [self.cartTableView indexPathForCell:cell];
    if (selectedIndexPath) {
        AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        [appDel.cartDataArray removeObjectAtIndex:selectedIndexPath.row];
        [self refreshView];
    }
}
-(void)callVenderOfCell:(CartCell *)cell
{
    NSIndexPath *selectedIndexPath = [self.cartTableView indexPathForCell:cell];
    if (selectedIndexPath) {
        AppDelegate *appDel = (AppDelegate *)[[UIApplication sharedApplication]delegate];
        Product *product = [appDel.cartDataArray objectAtIndex:selectedIndexPath.row];
        self.currentPhoneNumber = product.phoneNumber;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"RetailStore" message:[NSString stringWithFormat:@"Make call to %@",self.currentPhoneNumber] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
        [alert show];
        alert.tag = 99;
        alert.delegate = self;
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 99) {
        if (buttonIndex ==1) {
            NSString *phoneNumber = [@"tel://" stringByAppendingString:self.currentPhoneNumber];
            NSURL *phoneURL = [NSURL URLWithString:phoneNumber];
            if([[UIApplication sharedApplication]canOpenURL:phoneURL]){
                [[UIApplication sharedApplication] openURL:phoneURL];
            }
            
        }
    }
}

@end
