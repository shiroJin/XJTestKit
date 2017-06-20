//
//  NSString+JsonStringModel.m
//  CustomLogManager
//
//  Created by 金泉斌 on 2017/6/13.
//  Copyright © 2017年 金泉斌. All rights reserved.
//

#import "NSString+JsonStringModel.h"
#import <objc/runtime.h>

@implementation NSString (JsonStringModel)

- (NSArray *)jsonStringToModel:(Class)cls {
    NSString *jsonStr = self;
    if (!jsonStr || jsonStr.length == 0) return nil;
    NSError *error = nil;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:[jsonStr dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingMutableContainers error:&error];
    if (error) return nil;
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSDictionary *dic in arr) {
        id ojc = [cls new];
        unsigned int outCnt = 0;
        objc_property_t *propertyList = class_copyPropertyList(cls, &outCnt);
        for (int i = 0; i < outCnt; i++) {
            objc_property_t property = propertyList[i];
            const char *propertyName = property_getName(property);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            id value = [dic valueForKey:key];
            if (value) [ojc setValue:value forKey:key];
        }
        [result addObject:ojc];
    }
    return [result copy];
}

@end
