//
//  SalaryDetailsViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/13/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SalaryDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *basicLb;
@property (strong, nonatomic) IBOutlet UILabel *HRALb;
@property (strong, nonatomic) IBOutlet UILabel *medicalAllowanceLb;
@property (strong, nonatomic) IBOutlet UILabel *conveyanceLb;
@property (strong, nonatomic) IBOutlet UILabel *allowanceLb;
@property (strong, nonatomic) IBOutlet UILabel *EmployerPFLb;
@property (strong, nonatomic) IBOutlet UILabel *EmployerESILb;
@property (strong, nonatomic) IBOutlet UILabel *EmployeePFLb;
@property (strong, nonatomic) IBOutlet UILabel *EmployeeESILb;
@property (strong, nonatomic) IBOutlet UILabel *PTLb;
@property (strong, nonatomic) IBOutlet UILabel *CTCLb;
@property (strong, nonatomic) IBOutlet UILabel *totalDeductionLb;
@property (strong, nonatomic) IBOutlet UILabel *netSalaryLb;


@property (assign, nonatomic) float basic;
@property (assign, nonatomic) float basic2;
@property (assign, nonatomic) float gross;
@property (assign, nonatomic) float medical;
@property (assign, nonatomic) float conveyance;
@property (assign, nonatomic) float allowance;


@end
