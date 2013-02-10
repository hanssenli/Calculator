//
//  HALNumberToken.h
//  Calculator
//
//  Created by Hanssen Li on 2/7/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HALToken.h"

@interface HALNumberToken : NSObject <HALToken> {
    double number;
}
-(id)initWithNumber:(NSString *)number;
-(double) getNumber;
-(NSString *) toString;

@end
