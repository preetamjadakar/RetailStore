//
//  ProductCell.h
//  iWeather
//
//  Created by Preetam Jadakar on 20/02/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import <UIKit/UIKit.h>
//forward declaration of current class
@class ProductCell;

//protocol to handle button click of current cell
@protocol ProductCellProtocol <NSObject>
@required
-(void)addToCartFromCell:(ProductCell*)cell;
@end

//used to show City data in Collectionview
@interface ProductCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIImageView *productImage;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vAddLabel;
- (IBAction)addToCart:(id)sender;




//protocol's delegate
@property(weak)id<ProductCellProtocol>delegate;

@property(nonatomic)NSString *cityName;

@end
