//
//  HALViewController.m
//  Calculator
//
//  Created by Hanssen Li on 1/14/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALViewController.h"
#import "ctype.h"
#import "HALNumberToken.h"
#import "HALOperatorToken.h"
#import "HALParenthesesToken.h"
#import "HALInfixToPostFixConverter.h"
#import "HALPostfixEvaluator.h"

@interface HALViewController ()

@end

@implementation HALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printInfinity) name:@"printInfinity" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(printNan) name:@"printNan" object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitButtonPressed:(id)sender {
    if ([sender tag] != 10) {
        currentNumber = (float)[sender tag];
        
        self.displayText.text =  [NSString stringWithFormat:@"%@%.f", self.displayText.text, currentNumber];
    } else {
        self.displayText.text = [NSString stringWithFormat:@"%@.", self.displayText.text];
    }
}

- (IBAction)operationButtonPressed:(id)sender {
    switch ([sender tag]) {
        case 0:
            self.displayText.text =  [NSString stringWithFormat:@"%@ + ", self.displayText.text];
            break;
        case 1:
            self.displayText.text =  [NSString stringWithFormat:@"%@ - ", self.displayText.text];
            break;
            
        case 2:
            self.displayText.text =  [NSString stringWithFormat:@"%@ * ", self.displayText.text];
            break;

        case 3:
            self.displayText.text =  [NSString stringWithFormat:@"%@ / ", self.displayText.text];
            break;
            
        case 4:
            self.displayText.text =  [NSString stringWithFormat:@"%@^", self.displayText.text];
            break;

        case 5:
            self.displayText.text =  [NSString stringWithFormat:@"%@(", self.displayText.text];
            break;

        case 6:
            self.displayText.text =  [NSString stringWithFormat:@"%@)", self.displayText.text];
            break;
            
        default:
            break;
    }
}

- (IBAction)clearButtonPressed:(id)sender {
    self.displayText.text =  [NSString stringWithFormat:@""];
}
- (IBAction)calculateButtonPressed:(id)sender {
    NSString *input = self.displayText.text;
    
    // if nothing inputed
    if ([input length] == 0) return;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSMutableString *stringBuilder = [NSMutableString stringWithString:@""];
    for(int i = 0; i < [input length]; i++) {
        
        char c = [input characterAtIndex:i];
        
        // if the character is a digit
        if(isdigit(c) || c == '.') {
            
            [stringBuilder appendString:[NSString stringWithFormat:@"%c", c]];
            
            if(i + 1 < [input length]) {
                char d = [input characterAtIndex:(i + 1)];

                if((isdigit(d) == false && d != '.') && [stringBuilder length] > 0) {
                    [array addObject:[[HALNumberToken alloc] initWithNumber:stringBuilder]];
                    stringBuilder = [NSMutableString stringWithString:@""];
                }
            }
        }
        // if it is a higher operator
        else if( c == '*' || c == '/' || c == '^') {
            [array addObject:[[HALOperatorToken alloc] initWithOperator:c]];
        }
        // if it is + or -
        else if(c == '+' || c == '-') {
            if([array count] == 0) {
                [array addObject:[[HALNumberToken alloc] initWithNumber:@"0"]];
                [array addObject:[[HALOperatorToken alloc] initWithOperator:c]];
                continue;
            }
            else {

                if ([[array objectAtIndex:[array count] - 1] isKindOfClass:[HALParenthesesToken class]]) {
                    HALParenthesesToken *paren = [array objectAtIndex:[array count] - 1];
                    if([paren type] == LEFTPAREN) {
                        [array addObject:[[HALNumberToken alloc] initWithNumber:@"0"]];
                    }
                }
                [array addObject:[[HALOperatorToken alloc] initWithOperator:c]];

            
            }
            
        
        }
        // if it is a parenthesis
        else if(c == ')') {
            [array addObject:[[HALParenthesesToken alloc] initWithParentheses:c]];
            
        } 
        else if (c =='(') {
            // if these is no multiply sign, insert a multiply sign
            if (([array count] != 0) &&[[array objectAtIndex:[array count] - 1] isKindOfClass:[HALNumberToken class]] ) {
                [array addObject:[[HALOperatorToken alloc] initWithOperator:'*']];
                [array addObject:[[HALParenthesesToken alloc] initWithParentheses:c]];
            } else {
                [array addObject:[[HALParenthesesToken alloc] initWithParentheses:c]];

            }
        }
        
    }
    // convert number to numbertoken
    if([stringBuilder length] > 0) {
        [array addObject:[[HALNumberToken alloc] initWithNumber:stringBuilder]];
    }

    HALInfixToPostFixConverter *p = [[HALInfixToPostFixConverter alloc] init];
    array = [p ConvertFromInfixToPostfix:array];
    
    /*
    for(int i = 0; i < [array count]; i++) {
        NSLog([array[i] toString]);
    }
    */
    
    HALPostfixEvaluator *evaluator = [[HALPostfixEvaluator alloc] init];
    
    double answer = [evaluator Evaluate:array];
    
    NSString *output = self.displayText.text;
    if (![output isEqualToString:@"Infinity"] && ![output isEqualToString:@"NaN"]) {
        self.displayText.text = [NSString stringWithFormat:@"%.3f",answer];
    }

    // clear all objects
    [array removeAllObjects];

}

- (void)printInfinity
{
    self.displayText.text = @"Infinity";
    //NSLog(@"INFINITY");
}

- (void)printNan
{
    self.displayText.text = @"NaN";
    //NSLog(@"NAN");

}

@end