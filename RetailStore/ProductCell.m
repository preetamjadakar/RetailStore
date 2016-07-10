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
    

//    self.forecastTableView.contentInset = UIEdgeInsetsMake(50, 0, 0, 0);
}

- (IBAction)removeCell:(id)sender {
    
    if ([self.delegate respondsToSelector:@selector(removeButtonClicked:)]) {
        [self.delegate removeButtonClicked:self];
    }
}
@end
