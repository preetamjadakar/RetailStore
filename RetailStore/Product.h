//
//  Product.h
//  RetailStore
//
//  Created by Preetam Jadakar on 10/07/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject
@property(retain)NSString *productName;
@property(retain)NSNumber *productPrice;
@property(retain)NSString *imageURL;
@property(retain)NSString *venderName;
@property(retain)NSString *venderAddress;
@property(retain)NSString *phoneNumber;


@end
