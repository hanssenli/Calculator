//
//  HALPostfixEvaluator.h
//  Calculator
//
//  Created by Hanssen Li on 2/8/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HALStack.h"
#import "HALNumberToken.h"
#import "HALOperatorToken.h"

@interface HALPostfixEvaluator : NSObject {
    HALStack *stack;
}

-(HALNumberToken *) calculate:(HALNumberToken *) left
                             :(HALNumberToken *) right
                             :(HALOperatorToken *) op;
-(double)Evaluate: (NSMutableArray *) e;

@end
