//
//  ProductCell.m
//  iWeather
//
//  Created by Preetam Jadakar on 20/02/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import "ProductCell.h"

@implementation ProductCell
- (void)awakeFromNib {
    // Initialization code
    

//    self.CartTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
}

- (IBAction)addToCart:(id)sender {
    if ([self.delegate respondsToSelector:@selector(addToCartFromCell:)]) {
        [self.delegate addToCartFromCell:self];
    }
}
@end
