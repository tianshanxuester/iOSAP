//
//  SimpleCalculator.cpp
//  SimpleBlock
//
//  Created by yangzigang on 13-8-28.
//  Copyright (c) 2013年 yangzigang. All rights reserved.
//

#include "SimpleCalculator.h"

SimpleCalculator::SimpleCalculator()
{
    tag = 0;
}

int SimpleCalculator::add(int a, int b) const
{
    return a + b;
}

SimpleCalculator::SimpleCalculator(const SimpleCalculator &another)
{
    std::cout<<"SimpleCalculator copy constructor is invoked"<<&another<<"\t"<<this<<std::endl;
    tag = another.tag;
}
