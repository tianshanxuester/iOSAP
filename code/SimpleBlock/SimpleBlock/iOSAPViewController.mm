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


@interface iOSAPViewController ()

@property (nonatomic, copy) int (^addWithObjC)(int, int);
@property (nonatomic, assign) int tag;

@end

@implementation iOSAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self simpleBlockWithObjC];
}

- (void)simpleBlockWithObjC
{
    self.tag = 1;
    NSLog(@"self.retainCount is %i", self.retainCount);
    int (^addWithObjc)(int, int) = ^(int a, int b) {
        self.tag = 2;
        return a + b;
    };
    NSLog(@"self.retainCount is %i", self.retainCount);
    addWithObjc(1, 2);
    NSLog(@"self.tag is %i", self.tag);
}
@end

#if 0
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

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
