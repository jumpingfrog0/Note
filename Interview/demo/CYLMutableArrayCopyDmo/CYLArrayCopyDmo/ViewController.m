//
//  ViewController.m
//  CYLMutableArrayCopyDmo
//
//  Created by 陈宜龙 on 15/9/25.
//  Copyright © 2015年 http://weibo.com/luohanchenyilong/ 微博@iOS程序犭袁. All rights reserved.
//

#import "ViewController.h"

@interface Person : NSObject

@property (nonatomic, copy) NSString *name;

@end

@implementation Person

@end

@interface Tom : Person
@property (nonatomic, copy) NSString *name;

@end

@implementation Tom

//@synthesize name = __name;

- (instancetype)init
{
    self = [super init];
    if (self) {
//        __name = @"tom111";
//        self.name = @"aa";
//        __name = @"aa";
    }
    return self;
}
@end

@protocol PersonProtocol <NSObject>

@property (nonatomic, copy) NSString *age;

@end

@interface Joy: Person <PersonProtocol>
@end

@implementation Joy

@synthesize age = aage;

- (instancetype)init
{
    self = [super init];
    if (self) {
        aage = @"b";
    }
    return self;
}
@end

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
    
    Tom *tom = [[Tom alloc] init];
//    tom.name = @"tom";
    NSLog(@"%@", tom.name);
    
    Joy *joy = [[Joy alloc] init];
//    joy.age = @"1";
//    joy.aage = @"2";
    NSLog(@"%@", joy.age);
}

@end

