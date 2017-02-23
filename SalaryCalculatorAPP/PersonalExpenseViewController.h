//
//  PersonalExpenseViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/19/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"
#import "DayExpenses+CoreDataProperties.h"
#import "MonthExpenses+CoreDataProperties.h"

@interface PersonalExpenseViewController : UIViewController

@property (strong, nonatomic) MonthExpenses *monthExpensesData;
@property (strong, nonatomic) NSDate *currentMonth;


@property (strong, nonatomic) IBOutlet UITextField *monthTF;
@property (strong, nonatomic) IBOutlet UILabel *todayExpenseLb;
@property (strong, nonatomic) IBOutlet UILabel *monthExpenseLb;
@property (strong, nonatomic) IBOutlet UILabel *foodLb;
@property (strong, nonatomic) IBOutlet UILabel *healthCareLb;
@property (strong, nonatomic) IBOutlet UILabel *travelsLb;
@property (strong, nonatomic) IBOutlet UILabel *loansLb;
@property (strong, nonatomic) IBOutlet UILabel *entertainmentLb;
@property (strong, nonatomic) IBOutlet UILabel *automobileLb;
@property (strong, nonatomic) IBOutlet UILabel *insuranceLb;
@property (strong, nonatomic) IBOutlet UILabel *familyLb;
@property (strong, nonatomic) IBOutlet UILabel *taxLb;
@property (strong, nonatomic) IBOutlet UILabel *otherLb;
- (IBAction)ChartButton:(id)sender;

- (IBAction)TapGestrure:(id)sender;

@end
