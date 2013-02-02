//
//  HALViewController.m
//  Calculator
//
//  Created by Hanssen Li on 1/14/13.
//  Copyright (c) 2013 Hanssen Li. All rights reserved.
//

#import "HALViewController.h"

@interface HALViewController ()

@end

@implementation HALViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)digitButtonPressed:(id)sender {
    if ([sender tag] != 0) {
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

- (IBAction)calculateButtonPressed:(id)sender {

}

- (IBAction)clearButtonPressed:(id)sender {
    self.displayText.text =  [NSString stringWithFormat:@""];
}

@end
