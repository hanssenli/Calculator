//
//  HALOperatorToken.h
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HALToken.h"

typedef enum {
    ADD,
    SUBTRACT,
    MULTIPLY,
    DIVIDE,
    EXPONENTIAL
} OperatorType;

@interface HALOperatorToken : NSObject <HALToken>
{
    OperatorType type;
    char c;
}
-(id)initWithOperator:(char)OperatorIn;
-(NSString *) toString;
-(OperatorType) type;


@end
