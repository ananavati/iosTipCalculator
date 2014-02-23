//
//  SettingsViewController.m
//  MakeTip
//
//  Created by Arpan Nanavati on 2/23/14.
//  Copyright (c) 2014 Arpan Nanavati. All rights reserved.
//

#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UITextField *defaultTipPercentage;

@end

@implementation SettingsViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tipPercent = (int)[defaults integerForKey:@"user_set_tip_percent"];
    self.defaultTipPercentage.text = [NSString stringWithFormat:@"%d", tipPercent];
}

- (void)viewWillDisappear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int tipPercent = (int)[self.defaultTipPercentage.text floatValue];
    [defaults setInteger:tipPercent forKey:@"user_set_tip_percent"];
    [defaults synchronize];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
