//
//  SubClass.m
//  InitAndDeallocDemo
//
//  Created by 黄东鸿(EX-HUANGDONGHONG001) on 2018/12/17.
//  Copyright © 2018年 黄东鸿(EX-HUANGDONGHONG001). All rights reserved.
//

#import "SubClass.h"

@implementation SubClass
- (instancetype)init {
    if (self = [super init]) {
        _debugInfo = @"This is SubClass";
        self.subInfo = @"subInfo";
    }
    return self;
}

// 这里重载了父类 info 的 setter，会导致闪退
- (void)setInfo:(NSString *)info {
    NSLog(@"%@",[NSString stringWithString:self.debugInfo]);
    
    [super setInfo:info];
    NSString* copyString = [NSString stringWithString:self.subInfo];
    NSLog(@"%@",copyString);
}

- (void)dealloc {
    _debugInfo = nil;
}

@end
