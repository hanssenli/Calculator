//
//  HALInfixToPostFixConverter.m
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALInfixToPostFixConverter.h"
#import "HALViewController.h"
#import "HALParenthesesToken.h"
#import "HALToken.h"


@implementation HALInfixToPostFixConverter


- (int)Precedence: (HALOperatorToken *) c {
    if([c type] == EXPONENTIAL) {
        return 4;
    }
    else if([c type] == MULTIPLY || [c type] == DIVIDE) {
        return 3;
    }
    else if ([c type] == ADD || [c type] == SUBTRACT) {
        return 2;
    }
    else return -1000000;

}
- (BOOL)IS_LEFT_ASSOCIATIVE: (HALOperatorToken *) c {
    if([c type] == MULTIPLY || [c type] == DIVIDE || [c type] == ADD || [c type] == SUBTRACT)
    {
        //NSLog(@"IS LEFT ");

        return true;
    }
    else
    {
        //NSLog(@"IS NOT LEFT ");

        return false;
        
    }

}
- (void)processParentheses: (HALStack *) stackParen {
    while([stackParen count] > 0)
    {
        if ([[stackParen peek] isKindOfClass: [HALOperatorToken class]]) {
            [postfix addObject:[stackParen pop]];
        }
        else break;
    }

}
- (void)processOperators: (HALStack *) stackOp
                        : (HALOperatorToken *) token {
    
    //use peek() to look at the object at the top of this stack without removing it from the stack
    while([stackOp count] > 0)
    {
        int first = [self Precedence:token];
        int second = [self Precedence: [stackOp peek]];
        BOOL isLeftAssoc = [self IS_LEFT_ASSOCIATIVE:token];

        BOOL cond1 = ((isLeftAssoc == YES) && (first <= second));
        BOOL cond2 = ((isLeftAssoc == NO) && (first < second));
        
        //NSLog(@"Temp infix -> postfix conversion step-by-step results ");

        if(cond1 || cond2)
        {
            [postfix addObject:[stackOp pop]];
            continue;
        }
        break;
    }

}

- (NSMutableArray *) ConvertFromInfixToPostfix: (NSMutableArray *) e {
    NSMutableArray *infix = [[NSMutableArray alloc] init];
    infix = e;
    HALStack *stack = [[HALStack alloc] init];
    postfix = [[NSMutableArray alloc] init];
    
    //Display temp results step by step
    //NSLog(@"=====================================================");
    //NSLog(@"Temp infix -> postfix conversion step-by-step results ");

    
    for(int i = 0; i < [infix count]; i++) {
        // number token
        //NSLog(@"YOLO");
        //NSLog(@"current token = %@", [[infix objectAtIndex:i] toString]);
        if ([stack count] > 0) [stack toString];
        
        //NSLog(@"===========IN POSTFIX ARRAY =========================");
        /*
        for (int i = 0; i < [postfix count]; i++) {
            NSLog(@"tokens in postfix = %@", [[postfix objectAtIndex:i] toString]);
        }
        */
        //NSLog(@"===========IN POSTFIX ARRAY =========================");

        
        // number token
        if ([[infix objectAtIndex:i] isKindOfClass:[HALNumberToken class]]) {
            [postfix addObject: [infix objectAtIndex:i]];
            //NSLog(@"ENTERED NUMBER TOKEN SECTION");

        }

        // operator token
        else if ([[infix objectAtIndex:i] isKindOfClass:[HALOperatorToken class]]) {
            //NSLog(@"ENTERED OPERATIONS TOKEN SECTION");

            //if the stack is empty
            if([stack count] == 0) [stack push:[infix objectAtIndex:i]];
            
            //otherwise perform additional actions
            else
            {

                //ProcessOperators(stack, token);
                while([stack count] > 0 && [[stack peek] isKindOfClass: [HALOperatorToken class]])
                {
                    //NSLog(@"=========== WHILE LOOP OF OPERATIONS =========================");

                    int first = [self Precedence:[infix objectAtIndex:i]];
                    int second = [self Precedence: [stack peek]];
                    BOOL isLeftAssoc = [self IS_LEFT_ASSOCIATIVE:[infix objectAtIndex:i]];
                    
                    BOOL cond1 = (isLeftAssoc && first <= second);
                    BOOL cond2 = (isLeftAssoc == NO && first < second);
                    
                    //NSLog(@"First = %i", first);
                    //NSLog(@"Second = %i", second);
                    //NSLog (@"Value of my BOOL = %@", cond1? @"YES" : @"NO");
                    //NSLog (@"Value of my BOOL = %@", cond2? @"YES" : @"NO");
                    
                    if(cond1 || cond2)
                    {
                        [postfix addObject:[stack pop]];
                        continue;
                    }
                    break;    
                    
                }          
                [stack push:[infix objectAtIndex:i]];
                
            }
        
        }
        
        // parenthesis
        else if ([[infix objectAtIndex:i] isKindOfClass:[HALParenthesesToken class]])
        {
            
            //NSLog(@"ENTERED PARENTHESES TOKEN SECTION");

            HALParenthesesToken *token = [infix objectAtIndex:i];
    
            if([token type] == LEFTPAREN) {
                
                //is a left parenthesis
                [stack push:[infix objectAtIndex:i]];
                
                //NSLog(@"tokens in stack = %@", [[stack peek] toString]);

            }
            
            else //is a right parenthesis
            {
                BOOL parenthesisMismatch = YES;
                while([stack count] > 0)
                {
                    if ([[stack peek] isKindOfClass:[HALOperatorToken class]])
                    {
                        [postfix addObject:[stack pop]];
                    }
                    else if ([[stack peek] isKindOfClass:[HALParenthesesToken class]])
                    {
                        HALParenthesesToken *top = [stack peek];
                        if([top type] == LEFTPAREN) {
                            parenthesisMismatch = NO;
                            [stack pop];
                            break;
                        }
                    
                    }
                }
                if (parenthesisMismatch == YES)
                {
                    //NSLog(@"ERROR: Parentheses not matched!");
                    [postfix removeAllObjects];
                    break;
                }
            }     
        }
    
    
    }
    //pop all operators in stack
    while([stack count] > 0)
    {
        NSObject *remaining = [stack peek];
        if ([remaining isKindOfClass:[HALParenthesesToken class]])
        {
            //NSLog(@"ERROR: Parenthesis not matched!");
            [postfix removeAllObjects];
            break;
        }
        else [postfix addObject:[stack pop]];
    }
    
    return postfix;
}

- (NSString *) toString {
    NSMutableString *s = [[NSMutableString alloc] init];
    for(int j = 0; j < [postfix count]; j++) {
        [s appendString:[postfix objectAtIndex:j]];
        [s appendString:@" "];
    }
    return s;

}

@end
