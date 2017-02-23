

//
//  SalaryViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "SalaryViewController.h"
#import "SalaryDetailsViewController.h"

@interface SalaryViewController ()

@end

@implementation SalaryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.basicinPercentageTF.text = @"30";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.grossTF resignFirstResponder];
    [self.basicinPercentageTF resignFirstResponder];
    [self.basicinValueTF resignFirstResponder];
    [self.payDaysTF resignFirstResponder];
    [self.attendedTF resignFirstResponder];
    return YES;
}


- (IBAction)Calculate:(id)sender {
    
    
    
    BOOL missingFields = false;
    //    BOOL basicFieldsText = false;
    if (self.grossTF.text.length == 0) {
        missingFields = true;
        self.message = @"Please enter the gross value";
    } else if (self.basicinPercentageTF.text.length == 0 && self.basicinValueTF.text.length == 0) {
        missingFields = true;
        self.message = @"Please enter the basic value";
    } else if (self.basicinPercentageTF.text.length > 0 && self.basicinValueTF.text.length > 0) {
        missingFields = true;
        self.message = @"Please enter the basic value";
    } else if (self.payDaysTF.text.length == 0) {
        missingFields = true;
        self.message = @"Please enter the paydays value";
    } else if (self.attendedTF.text.length == 0) {
        missingFields = true;
        self.message = @"Please enter the attended value";
        
    }
    
    if (missingFields == true){
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Required fields are empty" message:self.message preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:Ok];
        [self presentViewController:alert animated:YES completion:nil];
        
    }
    else {
        self.value = [self.grossTF.text floatValue] * ([self.basicinPercentageTF.text floatValue]/100);
        self.HRA = [self.basicinValueTF.text floatValue] * 0.4;
        if ((self.value  + (self.value * 0.4)) > [self.grossTF.text floatValue]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter the gross value less than  basic value" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:Ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
        
        
        if (([self.basicinValueTF.text floatValue]  + self.HRA) > [self.grossTF.text floatValue]) {
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter the gross value less than  basic value" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction *Ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:Ok];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }


}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"send"]) {
        SalaryDetailsViewController *vc = [segue destinationViewController];
        
        vc.basic = ((([self.grossTF.text floatValue] * [self.basicinPercentageTF.text floatValue])/ [self.payDaysTF.text floatValue]) * [self.attendedTF.text floatValue])/100;
        
        
        vc.basic2 = (([self.basicinValueTF.text floatValue])/ [self.payDaysTF.text floatValue]) *[self.attendedTF.text floatValue];
        vc.gross = [self.grossTF.text floatValue];
        
    }
}

@end
