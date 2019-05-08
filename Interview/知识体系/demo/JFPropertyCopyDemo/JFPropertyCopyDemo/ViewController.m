//
//  ViewController.m
//  JFPropertyCopyDemo
//
//  Created by 黄东鸿(EX-HUANGDONGHONG001) on 2018/12/7.
//  Copyright © 2018年 黄东鸿(EX-HUANGDONGHONG001). All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic ,readwrite, strong) NSArray *array;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSArray *array = @[ @1, @2, @3, @4 ];
    NSMutableArray *mutableArray = [NSMutableArray arrayWithArray:array];
    
    self.array = mutableArray;
    [mutableArray removeAllObjects];;
    NSLog(@"%@",self.array);
    
    [mutableArray addObjectsFromArray:array];
    self.array = [mutableArray copy];
    [mutableArray removeAllObjects];;
    NSLog(@"%@",self.array);
}

@end
