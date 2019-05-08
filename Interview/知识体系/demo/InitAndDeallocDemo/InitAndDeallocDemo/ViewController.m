//
//  ViewController.m
//  InitAndDeallocDemo
//
//  Created by 黄东鸿(EX-HUANGDONGHONG001) on 2018/12/17.
//  Copyright © 2018年 黄东鸿(EX-HUANGDONGHONG001). All rights reserved.
//

#import "ViewController.h"
#import "SubClass.h"
#import "BaseClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    SubClass *sub = [[SubClass alloc] init];
}


@end
