//
//  iOSAPViewController.m
//  SimpleBlock
//
//  Created by yangzigang on 13-8-25.
//  Copyright (c) 2013年 yangzigang. All rights reserved.
//

#import "iOSAPViewController.h"
#import <objc/runtime.h>
#import "SimpleCalculator.h"

int(^add)(int, int);

@interface RealCalcuator : NSObject

@property (nonatomic, copy) int (^addWithObjC)(int, int);

@end

@implementation RealCalcuator

- (int)add:(int)a b:(int)b
{
    return self.addWithObjC(a, b);
}

@end

@interface SimpleCalculatorObjC : NSObject
@property (nonatomic, retain) NSString *stringForTest;
@property (nonatomic, retain) RealCalcuator *realCalculator;
@end

@implementation SimpleCalculatorObjC

- (id)init
{
    if (self = [super init]) {
        self.realCalculator = [[[RealCalcuator alloc] init] autorelease];
        self.stringForTest = @"just for test";
        NSLog(@"self.retainCount is %i", self.retainCount);
        NSLog(@"self.stringForTest.retainCount is %i", self.stringForTest.retainCount);
        self.realCalculator.addWithObjC = ^(int a, int b) {
            NSLog(@"%@", self.stringForTest);
            return a + b;
        };
        NSLog(@"self.retainCount is %i", self.retainCount);
        NSLog(@"self.stringForTest.retainCount is %i", self.stringForTest.retainCount);
    }
    return self;
}

- (void)dealloc
{
    NSLog(@"dealloc of %@ is invoked", self);
    self.stringForTest = nil;
    [super dealloc];
}

@end

@interface iOSAPViewController ()

@property (nonatomic, assign) int tag;

@end

@implementation iOSAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    SimpleCalculatorObjC *simpleCalculatorObjC = [[SimpleCalculatorObjC alloc] init];
    // 为了演示方便，下面这行代码使用了拖拉机式函数调用方式，在实际项目中不鼓励这种形式的代码
    int sum = simpleCalculatorObjC.realCalculator.addWithObjC(1, 2);
    NSLog(@"sum is %i", sum);
    [simpleCalculatorObjC release];
}
@end

#if 0


int sum = self.addWithObjC(1, 2);
NSLog(@"sum is %i", sum);
- (void)simpleBlock
{
    __block int x = 1;
    void (^outputValue) (int)  = ^(int y)  {
        x = 3;
        NSLog(@"x is %i, y is %i", x, y);
    };
    NSLog(@"origin x is %i", x);
    outputValue(2);
    NSLog(@"x is %i", x);
}

- (void)simpleBlockWithCPP
{
    SimpleCalculator *simpleCalculator = new SimpleCalculator();
    NSLog(@"simpleCalculator original address is：%p", simpleCalculator);
    int (^addWithCpp)(int, int) = ^(int a, int b) {
        NSLog(@"simpleCalculator address is：%p", simpleCalculator);
        NSLog(@"simpleCalculator.tag = %i", simpleCalculator->tag);
        return simpleCalculator->add(a, b);
    };
    simpleCalculator->tag = 10;
    int sum = addWithCpp(1, 2);
    NSLog(@"sum is %i", sum);
}

- (void)simpleBlockWithCPP2
{
    SimpleCalculator simpleCalculator = SimpleCalculator();
    NSLog(@"simpleCalculator original address is：%p", &simpleCalculator);
    self.addWithCpp = ^(int a, int b) {
        NSLog(@"simpleCalculator address is：%p", &simpleCalculator);
        NSLog(@"simpleCalculator.tag = %i", simpleCalculator.tag);
        return simpleCalculator.add(a, b);
    };
    NSLog(@"simpleCalculator address after block is：%p", &simpleCalculator);
    simpleCalculator.tag = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#endif
