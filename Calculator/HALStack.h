//
//  HALStack.h
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//
//  This implementation is from http://aramk.com/ios/generic-stack-for-objective-c/


static const int kFMStackDefaultCapacity = 10;

#import <Foundation/Foundation.h>

@interface HALStack : NSObject {
    
    NSMutableArray *stack;
}

- (id)initWithCapacity:(int)capacity;

- (void)push:(id)object;
- (id)pop;
- (void)clear;
- (int)count;
- (id)peek;
- (NSString *)toString;


@end
