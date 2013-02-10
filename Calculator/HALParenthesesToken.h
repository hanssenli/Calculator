//
//  HALParenthesesToken.h
//  Calculator
//
//  Created by Hanssen Li on 2/8/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HALToken.h"

typedef enum {
    LEFTPAREN,
    RIGHTPAREN
} ParenthesesType;

@interface HALParenthesesToken : NSObject <HALToken> {
    ParenthesesType type;
    char c;
}

-(id)initWithParentheses:(char)ParenthesesIn;
-(NSString *) toString;
-(ParenthesesType) type;



@end
