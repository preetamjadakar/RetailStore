//
//  CartCell.h
//  iWeather
//
//  Created by Preetam Jadakar on 20/02/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import <UIKit/UIKit.h>
//forward declaration of current class
@class CartCell;

//protocol to handle button click of current cell
@protocol CartCellProtocol <NSObject>
@required
-(void)removeCartItemFromCell:(CartCell*)cell;
-(void)callVenderOfCell:(CartCell*)cell;

@end
//used to show forcast data in tableview 
@interface CartCell : UITableViewCell


@property(weak)id<CartCellProtocol>delegate;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UILabel *priceLabel;
@property (weak, nonatomic) IBOutlet UILabel *vNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *vAddLabel;
- (IBAction)callVender:(id)sender;

- (IBAction)removeFromCart:(id)sender;
@end
