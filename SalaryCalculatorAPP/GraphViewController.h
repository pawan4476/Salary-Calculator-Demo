//
//  GraphViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/26/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"
#import "DayExpenses+CoreDataProperties.h"
#import "MonthExpenses+CoreDataProperties.h"


@class BarChart;
@interface GraphViewController : UIViewController

@property (strong, nonatomic) MonthExpenses *monthExpensesData;
@property (strong, nonatomic) NSDate *currentMonth;
    
//@property (nonatomic)float foodTotal;
//@property (nonatomic)float healthCare;
//@property (nonatomic)float automobile;
//@property (nonatomic)float family;
//@property (nonatomic)float insurance;
//@property (nonatomic)float entertainment;
//@property (nonatomic)float loans;
//@property (nonatomic)float travels;
//@property (nonatomic)float tax;
//@property (nonatomic)float other;


- (IBAction)tapGesture:(id)sender;

@property (strong, nonatomic) BarChart *barChartView;
@property (strong, nonatomic) IBOutlet UITextField *graphDateTF;


@end
