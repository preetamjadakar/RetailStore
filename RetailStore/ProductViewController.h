//
//  ProductViewController.h
//  RetailStore
//
//  Created by Preetam Jadakar on 09/07/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductCell.h"

@interface ProductViewController : UIViewController <UICollectionViewDataSource,UICollectionViewDelegate,ProductCellProtocol>

@end
