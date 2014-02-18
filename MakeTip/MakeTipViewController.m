//
//  MakeTipViewController.m
//  MakeTip
//
//  Created by Arpan Nanavati on 2/17/14.
//  Copyright (c) 2014 Arpan Nanavati. All rights reserved.
//

#import "MakeTipViewController.h"

@interface MakeTipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipPercentLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalAmountLabel;
@property (weak, nonatomic) IBOutlet UISlider *tipSlider;
@property (weak, nonatomic) IBOutlet UIStepper *tipStepper;

- (IBAction)onTap:(id)sender;
- (IBAction)onSwipeUp:(id)sender;
- (void)updateAllValues;

@end

@implementation MakeTipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.billAmountTextField becomeFirstResponder];
    [self updateAllValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self updateAllValues];
}

- (IBAction)onSwipeUp:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onSliderChanged:(id)sender {
    UISlider *slider = (UISlider *)sender;
    
    int tipPercent = (int)slider.value;
    
    self.tipPercentLabel.text = [NSString stringWithFormat:@"(%d%%)", tipPercent];
}

- (void)updateAllValues {
    float billAmount = [self.billAmountTextField.text floatValue];
    int tipStepValue = (int)self.tipStepper.value;
    int tipSliderValue = (int)self.tipSlider.value;
    int tipPercent = tipStepValue > 0 ? tipStepValue + tipSliderValue : tipSliderValue;
    
    float tipAmount = billAmount * tipPercent/100;
    float totalAmount = tipAmount + billAmount;
//    NSLog(@"%d%%", tipAmount);
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%d%%", tipPercent];
}
@end
