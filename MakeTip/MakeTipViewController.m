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
@property (weak, nonatomic) IBOutlet UILabel *personCount;
@property (weak, nonatomic) IBOutlet UILabel *tipPerPersonLabel;
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
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];

    self.personCount.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"user_male2-512.png"]];
    
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

- (void) onSettingsButton {
    [self.navigationController pushViewController:[[SettingsViewController alloc] init] animated:YES];
}


- (void)viewDidAppear:(BOOL)animated {
    // set the tip slider value from the cookie
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tipPercent = (int)[defaults integerForKey:@"user_set_tip_percent"];
    
    // set the default tip vaule on the slider
    tipPercent = tipPercent > 0 ? tipPercent : 18;
    self.tipSlider.value = tipPercent;
    
    [defaults setInteger:tipPercent forKey:@"user_set_tip_percent"];
    [defaults synchronize];
    
    [self updateAllValues];
}

- (void)updateAllValues {
    float billAmount = [self.billAmountTextField.text floatValue];
    int personCountValue = (int)self.tipStepper.value;
    int tipSliderValue = (int)self.tipSlider.value;
    
    float tipAmount = billAmount * tipSliderValue/100;
    float totalAmount = tipAmount + billAmount;
    float tipPerPerson = tipAmount/personCountValue;
    
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
    self.totalAmountLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    self.tipPercentLabel.text = [NSString stringWithFormat:@"%d%%", tipSliderValue];
    self.personCount.text = [NSString stringWithFormat:@"%d", personCountValue];
    self.tipPerPersonLabel.text = [NSString stringWithFormat:@"$%0.2f", tipPerPerson];
}
@end
