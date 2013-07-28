//
//  ViewController.m
//  DollarYen
//
//  Created by Takeshi Bingo on 2013/07/22.
//  Copyright (c) 2013年 Takeshi Bingo. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
{
    double input;
    double result;
    double rate;
// 円ー＞ドル　Ture　ドルー＞円　False
    bool isYenDollar;
    IBOutlet UILabel *inputCurrency;
    IBOutlet UILabel *resultCurrency;
    IBOutlet UILabel *rateLabel;
    IBOutlet UILabel *resultLabel;
    
    IBOutlet UISegmentedControl *selector;
    IBOutlet UITextField *inputField;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    rate = 101.5;
    
    input = 0;
    result = 0;
    
    [rateLabel setText:[NSString stringWithFormat:@"%.1f",rate]];
    isYenDollar = TRUE;
    
    inputField.delegate = self;
}

-(void)convert
{
    if (isYenDollar == TRUE){
        result = input / rate;
        [resultLabel setText:[NSString stringWithFormat:@"%.2f",result]];
    } else if (isYenDollar == FALSE){
        result = input * rate;
        // NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
        // [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
       // NSString *string = [formatter stringFromNumber:result];
        // [resultLabel setText:[NSString stringWithFormat:@"%.0f",result]];
        // resultLabel.text = [formatter stringFromNumber:result];
        NSNumber *number = [[NSNumber alloc] initWithDouble:result];
        NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init] ;
        [fmt setPositiveFormat:@"#,##0.00;0.00;-#,##0.00"];
        NSString *str = [fmt stringForObjectValue:number];
        resultLabel.text = str;

    }
}
-(IBAction)changeCalcMethod:(id)sender
{
    if (selector.selectedSegmentIndex == 0) {
        isYenDollar = YES;
        [inputCurrency setText:@"円"];
        [resultCurrency setText:@"ドル"];
    } else if (selector.selectedSegmentIndex == 1){
        isYenDollar = FALSE;
        [inputCurrency setText:@"ドル"];
        [resultCurrency setText:@"円"];
    }
[self convert];
}

-(BOOL)textFieldShouldReturn:(UITextField *)sender{
    input = [sender.text doubleValue];
    
    [sender resignFirstResponder];
    [self convert];
    return TRUE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
