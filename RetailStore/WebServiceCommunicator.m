//
//  WebServiceCommunicator.m
//  iWeather
//
//  Created by Preetam Jadakar on 20/02/16.
//  Copyright © 2016 Preetam Jadakar. All rights reserved.
//

#import "WebServiceCommunicator.h"
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "Product.h"
@implementation WebServiceCommunicator
+ (WebServiceCommunicator *)sharedInstance
{
    static WebServiceCommunicator *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[WebServiceCommunicator alloc] init];
    });
    return _sharedInstance;
}
-(BOOL)isNetworkConnection
{
    if([[Reachability sharedReachability] internetConnectionStatus] == NotReachable) {
        
        return NO;
    }else
        return YES;
}


-(void)fetchProductsListWithCompletionHandler:(void (^)(NSMutableArray *, NSError *))completionHandler
{
    NSString *apiString = [NSString stringWithFormat:@"https://mobiletest-hackathon.herokuapp.com/getdata/"];
   
    
    NSURL *URL = [NSURL URLWithString:apiString];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        
        if (data && !connectionError) {
            //success piece
            NSError *jsonExtractError;
            NSDictionary *dataDic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&jsonExtractError];
            
            if (dataDic) {
                NSArray *data = [dataDic valueForKey:@"products"];
                if ( data.count) {
                    
                    NSMutableArray *mainArray = [NSMutableArray new];
                    
                    for (NSDictionary *dic in data) {
                        Product *pr = [[Product alloc]init];
                        
                        pr.productName = [dic valueForKey:@"productname"];
                        pr.productPrice = [dic valueForKey:@"price"];
                        pr.venderName = [dic valueForKey:@"vendorname"];
                        pr.venderAddress = [dic valueForKey:@"vendoraddress"];
                        pr.phoneNumber = [dic valueForKey:@"phoneNumber"];
                        pr.imageURL = [dic valueForKey:@"productImg"];

                        [mainArray addObject:pr];
                    }
                    completionHandler(mainArray,nil);

                }
                else
                {
                    //service success with data failure, error shown as-is
                    NSMutableDictionary* details = [NSMutableDictionary dictionary];
                    [details setValue:[dataDic valueForKey:@"message"] forKey:NSLocalizedDescriptionKey];
                    NSError *error = [NSError errorWithDomain:@"RetailStore" code:304 userInfo:details];
                    
                    completionHandler(nil,error);
                }

            }
            else
            {
                //data parsing error
                
            }
        }
        else
        {
            //unexpected error
            NSMutableDictionary* details = [NSMutableDictionary dictionary];
            [details setValue:@"Unexpected error occoured. Please try later." forKey:NSLocalizedDescriptionKey];
            NSError *error = [NSError errorWithDomain:@"RetailStore" code:-50 userInfo:details];
            
            completionHandler(nil,error);

        }
        
    }];
}
@end
