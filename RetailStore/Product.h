//
//  Product.h
//  RetailStore
//
//  Created by Preetam Jadakar on 10/07/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(nonatomic)NSString *productName;
@property(nonatomic)NSNumber *productPrice;
@property(nonatomic)NSString *imageURL;
@property(nonatomic)NSString *venderName;
@property(nonatomic)NSString *venderAddress;
@property(nonatomic)NSString *phoneNumber;


@end
