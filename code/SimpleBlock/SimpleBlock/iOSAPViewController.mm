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

@end

@implementation iOSAPViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    add = ^(int a, int b){
        return a + b;
    };
    NSLog(@"%@", [add class]);
    NSLog(@"%i", [add retainCount]);
    
//    [self simpleBlock];
    [self simpleBlockWithCPP];
}

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
    SimpleCalculator simpleCalculator;
    NSLog(@"%p", &simpleCalculator);
    self.addWithCpp = ^(int a, int b) {
        NSLog(@"%p", &simpleCalculator);
        NSLog(@"simpleCalculator.tag = %i", simpleCalculator.tag);
        return simpleCalculator.add(a, b);
    };
    
    simpleCalculator.tag = 10;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.addWithCpp(1, 2);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end