//
//  CartCell.m
//  iWeather
//
//  Created by Preetam Jadakar on 20/02/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import "CartCell.h"

@implementation CartCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (IBAction)callVender:(id)sender {
    if ([self.delegate respondsToSelector:@selector(callVenderOfCell:)]) {
        [self.delegate callVenderOfCell:self];
    }
}

- (IBAction)removeFromCart:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(removeCartItemFromCell:)]) {
        [self.delegate removeCartItemFromCell:self];
    }

}
@end
