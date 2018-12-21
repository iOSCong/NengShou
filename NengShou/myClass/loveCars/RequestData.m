//
//  RequestData.m
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import "RequestData.h"

@implementation RequestData

- (id)initWithURLString:(NSString *)urlString parameterDic:(NSDictionary *)dictionary delegate:(id<RequestDataDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.delegate = delegate;
        [self requestDataWith:urlString parameterDic:dictionary];
    }
    return self;
}

- (void)requestDataWith:(NSString *)urlString parameterDic:(NSDictionary *)dictionary
{
    NSArray * allKeys = [dictionary allKeys];
    NSString * newURLString = [urlString stringByAppendingString:@"?"];
    for (int i = 0 ; i < [allKeys count]; i ++) {
        if (i == [allKeys count]-1) {
            newURLString = [[[newURLString stringByAppendingString:allKeys[i]] stringByAppendingString:@"="] stringByAppendingString:dictionary[allKeys[i]]];
        }else{
            newURLString = [[[[newURLString stringByAppendingString:allKeys[i]] stringByAppendingString:@"="] stringByAppendingString:dictionary[allKeys[i]]] stringByAppendingString:@"&"];
        }
    }
//    NSLog(@"----url==%@--",newURLString);
    NSMutableURLRequest * request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:newURLString]];
    //请求数据
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if ([self.delegate respondsToSelector:@selector(requestData:succeedRequestData:)] && data != nil) {
            [self.delegate requestData:self succeedRequestData:data];
        }
    }];
}

@end
