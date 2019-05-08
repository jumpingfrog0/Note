//
//  SubClass.h
//  InitAndDeallocDemo
//
//  Created by 黄东鸿(EX-HUANGDONGHONG001) on 2018/12/17.
//  Copyright © 2018年 黄东鸿(EX-HUANGDONGHONG001). All rights reserved.
//

#import "BaseClass.h"

NS_ASSUME_NONNULL_BEGIN

@interface SubClass : BaseClass
@property (nonatomic) NSString* debugInfo;
@property (nonatomic) NSString* subInfo;
@end

NS_ASSUME_NONNULL_END
