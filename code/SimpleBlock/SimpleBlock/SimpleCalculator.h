//
//  SimpleCalculator.h
//  SimpleBlock
//
//  Created by yangzigang on 13-8-28.
//  Copyright (c) 2013年 yangzigang. All rights reserved.
//

#ifndef __SimpleBlock__SimpleCalculator__
#define __SimpleBlock__SimpleCalculator__

#include <iostream>

class SimpleCalculator {
    
public:
    int tag;
    int add(int a, int b) const;
    SimpleCalculator();
    SimpleCalculator(const SimpleCalculator &another);
//    SimpleCalculator(const SimpleCalculator &another);
};

#endif /* defined(__SimpleBlock__SimpleCalculator__) */
