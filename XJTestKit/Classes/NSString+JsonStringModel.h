//
//  NSString+JsonStringModel.h
//  CustomLogManager
//
//  Created by 金泉斌 on 2017/6/13.
//  Copyright © 2017年 金泉斌. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JsonStringModel)

- (NSArray *)jsonStringToModel:(Class)cls;

@end
