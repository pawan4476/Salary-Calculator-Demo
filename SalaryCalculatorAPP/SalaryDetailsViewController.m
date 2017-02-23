//
//  SalaryDetailsViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "SalaryDetailsViewController.h"

@interface SalaryDetailsViewController ()

@end

@implementation SalaryDetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc]init];
    [numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
    [numberFormatter setMaximumFractionDigits:2];
    [numberFormatter setRoundingMode:NSNumberFormatterRoundUp];
    
    if (self.basic > 0){
        
        self.basicLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic]];
        self.HRALb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic*0.4]];
        self.EmployerPFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic*0.131]];
        self.EmployeePFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic*0.12]];
        
        
    }
    else{
        
        self.basicLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2]];
        self.HRALb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2*0.4]];
        self.EmployerPFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2*0.131]];
        self.EmployeePFLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.basic2*0.12]];
        
        
        
    }
    
    if (self.gross < 15000 ) {
        self.EmployerESILb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross*0.0475]];
        self.EmployeeESILb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross*0.0175]];
        self.PTLb.text = @"0";
        if (self.basic > 0) {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + (self.basic*0.131) + (self.gross*0.0475)+0]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:0+(self.gross*0.0175) + (self.basic*0.12)]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (0+(self.gross*0.0175) + (self.basic*0.12))]];
        } else {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + (self.basic2*0.131) + (self.gross*0.0475)+0]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:0+(self.gross*0.0175) + (self.basic2*0.12)]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (0+(self.gross*0.0175) + (self.basic2*0.12))]];
            
            
            
        }
    } else {
        
        self.EmployerESILb.text = @"0";
        self.EmployeeESILb.text = @"0";
        self.PTLb.text = @"200";
        
        if (self.basic > 0) {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + (self.basic*0.131) + 0+200]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:200 + (self.basic*0.12) + 0]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (200 + (self.basic*0.12) + 0)]];
            
            
        } else {
            self.CTCLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross + (self.basic2*0.131) + 0+200]];
            self.totalDeductionLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:200 + (self.basic2*0.12) + 0]];
            self.netSalaryLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (200 + (self.basic2*0.12) + 0)]];
            
            
            
            
        }
        
        
    }
    
    
    if (self.basic > 0) {
        if ((self.basic + (self.basic *0.4) + 1250 + 1600) > self.gross) {
            self.medicalAllowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(9.6/21.9) * (self.gross - (self.basic + (self.basic*0.4)))]];
            self.conveyanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(12.31/21.9) * (self.gross - (self.basic + (self.basic*0.4)))]];
            self.allowanceLb.text = @"0";
        } else {
            self.medicalAllowanceLb.text = @"1250";
            self.conveyanceLb.text = @"1600";
            self.allowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (self.basic + (self.basic * 0.4) + 1250 + 1600)]];
        }
    }
    else {
        
        if ((self.basic2 + (self.basic2 *0.4) + 1250 + 1600) > self.gross) {
            self.medicalAllowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(9.6/21.9) * (self.gross - (self.basic2 + (self.basic2*0.4)))]];
            self.conveyanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:(12.31/21.9) * (self.gross - (self.basic2 + (self.basic2*0.4)))]];
            self.allowanceLb.text = @"0";
        } else {
            self.medicalAllowanceLb.text = @"1250";
            self.conveyanceLb.text = @"1600";
            self.allowanceLb.text = [numberFormatter stringFromNumber:[NSNumber numberWithFloat:self.gross - (self.basic2 + (self.basic2 * 0.4) + 1250 + 1600)]];
        }
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
