//
//  HALStack.m
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALStack.h"

@implementation HALStack

- (id)init {
    return [self initWithCapacity:kFMStackDefaultCapacity];
}

- (id)initWithCapacity:(int)capacity {
    self = [super init];
    if (self) {
        stack = [[NSMutableArray alloc] initWithCapacity:capacity];
    }
    return self;
}

- (void)push:(id)object {
    [stack addObject:object];
}

- (id)pop {
    id object = [stack lastObject];
    NSAssert(object != nil, @"Nothing to pop from stack");
    [stack removeObject:object];
    return object;
}
- (id)peek {
    id object = [stack lastObject];
    NSAssert(object != nil, @"Nothing to pop from stack");
    return object;
}

- (void)clear {
    [stack removeAllObjects];
}

- (int)count {
    return [stack count];
}

- (NSString *)toString {
    NSMutableString *output = [NSMutableString stringWithString:@""];
    for (int i = 0; i< [stack count]; i++) {
        [output appendString:[[stack objectAtIndex:i] toString]];
        [output appendString:@" , "];

    }
    return output;
}



@end
