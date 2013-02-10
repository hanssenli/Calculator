//
//  HALParenthesesToken.m
//  Calculator
//
//  Created by Hanssen Li on 2/8/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALParenthesesToken.h"

@implementation HALParenthesesToken

-(id)initWithParentheses:(char)ParenthesesIn{
    c = ParenthesesIn;
    if(ParenthesesIn == '(' ) type = LEFTPAREN;
    else if(ParenthesesIn == ')') type = RIGHTPAREN;
    return [self init];
}


-(NSString *) toString{
    return [NSString stringWithFormat:@"%c", c];
}

-(ParenthesesType) type {
    return type;
}

@end
