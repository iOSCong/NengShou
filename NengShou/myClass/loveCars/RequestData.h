//
//  RequestData.h
//  CarsStore
//
//  Created by Apple on 15-1-20.
//  Copyright (c) 2015年 蓝欧科技. All rights reserved.
//

#import <Foundation/Foundation.h>
@class RequestData;
@protocol RequestDataDelegate <NSObject>

- (void)requestData:(RequestData *)requestData succeedRequestData:(NSData *)data;

@end

@interface RequestData : NSObject

@property (nonatomic,assign)id<RequestDataDelegate>delegate;

- (id)initWithURLString:(NSString *)urlString parameterDic:(NSDictionary *)dictionary delegate:(id<RequestDataDelegate>)delegate;

@end
