//
//  HALOperatorToken.m
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALOperatorToken.h"

@implementation HALOperatorToken

-(id)initWithOperator:(char)OperatorIn{
    c = OperatorIn;
    if(OperatorIn == '+')        type = ADD;
    else if(OperatorIn == '-')   type = SUBTRACT;
    else if(OperatorIn == '*')   type = MULTIPLY;
    else if(OperatorIn == '/')   type = DIVIDE;
    else if(OperatorIn == '^')   type = EXPONENTIAL;
    return [self init];
}
-(NSString *) toString{
    return [NSString stringWithFormat:@"%c", c];
}

-(OperatorType) type{
    return type;
}

@end
