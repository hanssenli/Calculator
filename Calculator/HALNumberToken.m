//
//  HALNumberToken.m
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALNumberToken.h"

@implementation HALNumberToken

-(id)initWithNumber:(NSString *)numberIn{
    number = [numberIn doubleValue];
    return [self init];
}

-(double) getNumber {
    return number;

}
-(NSString *) toString{
    return [NSString stringWithFormat:@"%lf", number];
}

@end
