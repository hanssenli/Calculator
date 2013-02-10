//
//  HALPostfixEvaluator.m
//  Calculator
//
//  Created by Hanssen Li on 2/8/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALPostfixEvaluator.h"
#import "math.h"

@implementation HALPostfixEvaluator

-(HALNumberToken *) calculate:(HALNumberToken *) left
                             :(HALNumberToken *) right
                             :(HALOperatorToken *) op {

    double temp = INFINITY;
    if([op type] == ADD)
    {
        temp = [left getNumber] + [right getNumber];
    }
    else if([op type] == SUBTRACT)
    {
        temp = [left getNumber] - [right getNumber];
    }
    else if([op type] == MULTIPLY)
    {
        temp = [left getNumber] * [right getNumber];
    }
    else if([op type] == DIVIDE)
    {
        if (fabs([right getNumber]) > 0) {
            temp = [left getNumber] / [right getNumber];
        } 
        else {
            //NSLog(@"ERROR: Division by 0!");
            temp = INFINITY;
            [[NSNotificationCenter defaultCenter]postNotificationName:@"printInfinity" object:nil];
            return [[HALNumberToken alloc] initWithNumber:@"INFINITY"];
            // Post a notification
        }
    }
    else if([op type] == EXPONENTIAL)
    {
        temp = pow([left getNumber], [right getNumber]);
        // if (Math.abs(right.getNumber())>=1 || (Math.abs(right.getNumber())<1 && left.getNumber() >=0))
        //   temp = Math.pow(left.getNumber(), right.getNumber());
        // else System.out.println("ERROR: Calculating root of a negative number!");
        if (isnan(temp)){
            //NSLog(@"ERROR: Calculating root of a negative number!");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"printNan" object:nil];
            temp = 0.0;
            //break;
        }
    }
    return [[HALNumberToken alloc] initWithNumber:[NSString stringWithFormat:@"%f", temp]];
}


-(double)Evaluate: (NSMutableArray *) e {
    stack = [[HALStack alloc] init];
    NSMutableArray *v = e;
    for(int i = 0; i < [v count]; i++) {
        if([[v objectAtIndex:i] isKindOfClass:[HALNumberToken class]]) {
            [stack push:[v objectAtIndex:i]];
        }
        else if ([[v objectAtIndex:i] isKindOfClass:[HALOperatorToken class]]) {
            HALNumberToken *right = [stack pop];
            HALNumberToken *left = [stack pop];
            HALNumberToken *result = [self calculate:left :right :[v objectAtIndex:i]];
            [stack push:result];

        }
    }
    return [[stack pop] getNumber];

}

@end
