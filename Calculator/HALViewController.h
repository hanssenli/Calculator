//
//  HALViewController.h
//  Calculator
//
//  Created by Hanssen Li on 1/14/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HALViewController : UIViewController
{
    float currentNumber;
}
@property (strong, nonatomic) IBOutlet UILabel *displayText;
- (IBAction)digitButtonPressed:(id)sender;
- (IBAction)operationButtonPressed:(id)sender;
- (IBAction)calculateButtonPressed:(id)sender;
- (IBAction)clearButtonPressed:(id)sender;

@end
