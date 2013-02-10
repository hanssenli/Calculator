//
//  HALInfixToPostFixConverter.h
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HALStack.h"
#import "HALOperatorToken.h"
#import "HALNumberToken.h"
#import "HALToken.h"


@interface HALInfixToPostFixConverter : NSObject {

    NSMutableArray *postfix;
    
}

- (int)Precedence: (HALOperatorToken *) c;
- (BOOL)IS_LEFT_ASSOCIATIVE: (HALOperatorToken *) c;
- (void)processOperators:(HALStack *)stackOp
                        :(HALNumberToken *) token;
- (void)processParentheses: (HALStack *) stackParen;
- (NSMutableArray *) ConvertFromInfixToPostfix: (NSMutableArray *) e;
- (NSString *) toString;

@end
