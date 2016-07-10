//
//  ProductViewController.m
//  RetailStore
//
//  Created by Preetam Jadakar on 09/07/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import "ProductViewController.h"
#import "MBProgressHUD.h"
#import "WebServiceCommunicator.h"
#import "ProductCell.h"
#import "Product.h"
#define kNetworkErrorMessage @"Internet or Wi fi is not available."
#define kProductCellID @"ProductCellId"
#define PADDING 10


@interface ProductViewController ()
@property (strong, nonatomic) IBOutlet UICollectionView *productsCollectionView;
@property (strong, nonatomic)MBProgressHUD *activityIndicatorView;
@property (nonatomic)NSMutableArray* dataSource;

@end

@implementation ProductViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //fetch data
    
    
    self.activityIndicatorView = [[MBProgressHUD alloc] initWithView:self.view];
    [self.navigationController.view addSubview:self.activityIndicatorView];
    self.activityIndicatorView.opacity = 0.5;
    
    
    
    //collectionview set up
    self.productsCollectionView.backgroundColor = [UIColor clearColor];
    
    [self.productsCollectionView registerNib:[UINib nibWithNibName:@"ProductCell" bundle:nil] forCellWithReuseIdentifier:kProductCellID];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    layout.sectionInset = UIEdgeInsetsMake(PADDING, PADDING,PADDING*3, PADDING);
    layout.minimumInteritemSpacing = PADDING*2;
    [self.productsCollectionView setCollectionViewLayout:layout];
    
    
    [self fetchData];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UICollectionViewDataDelegates
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ProductCell *cell =
    (ProductCell *)[self.productsCollectionView dequeueReusableCellWithReuseIdentifier:kProductCellID
                                                                        forIndexPath:indexPath];
    cell.delegate = self;
    
    [self addSomeBorderToCell:cell];
    Product *product = [self.dataSource objectAtIndex:indexPath.row];
    
//    cell.cityName = product.cityName;
//    cell.forecastDataArray = product.forecastArray;
    
    // to refresh table in collectionview cell
    
    return cell;
    
}

-(void)addSomeBorderToCell:(ProductCell*)cell
{
    cell.layer.borderColor = [UIColor whiteColor].CGColor;
    cell.layer.borderWidth = .50;
    cell.layer.masksToBounds = NO;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGSize collectionViewSize = self.productsCollectionView.bounds.size;
    return CGSizeMake(collectionViewSize.width/2-2*PADDING, collectionViewSize.width/2-2*PADDING);
}
#pragma mark WebserviceCommunicator Delegate Response
//just to avaid code redundency, made it reusable
-(void)fetchData
{
    if ([[WebServiceCommunicator sharedInstance]isNetworkConnection]) {
        [self.activityIndicatorView show:YES];
        
        [[WebServiceCommunicator sharedInstance]fetchProductsListWithCompletionHandler:^(NSMutableArray *data, NSError *error) {
            
            if (error == nil) {
                self.dataSource = [NSMutableArray new];

                self.dataSource = data;
                [self.productsCollectionView reloadData];
                
                [self.activityIndicatorView hide:YES];
                
            }
            else
            {
                [self.activityIndicatorView hide:YES];
                
                [[[UIAlertView alloc]initWithTitle:@"Error" message:error.localizedDescription delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]show];
            }
            
        }];
    }
    else
    {
        [[[UIAlertView alloc]
          initWithTitle:@"Error" message:kNetworkErrorMessage delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil] show];
    }
    
}

@end
