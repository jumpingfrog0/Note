//
//  BaseClass.m
//  InitAndDeallocDemo
//
//  Created by 黄东鸿(EX-HUANGDONGHONG001) on 2018/12/17.
//  Copyright © 2018年 黄东鸿(EX-HUANGDONGHONG001). All rights reserved.
//

#import "BaseClass.h"

@implementation BaseClass
- (instancetype)init {
    if ([super init]) {
        // 子类会调用父类的 init 方法
        // 如果子类重载了 info 的setter，这里是有问题的，可能会闪退，因为子类对象还没有初始化完毕
        self.info = @"baseInfo";
    }
    return self;
}

- (void)dealloc {
    // 子类释放的时候，会先调子类的dealloc，然后会调用父类的dealloc
    // 如果子类重载了 info 的seter，执行到这里的时候会奔溃，因为此时 self 是子类的指针，而此时子类已经释放了
    self.info = nil;
}
@end
