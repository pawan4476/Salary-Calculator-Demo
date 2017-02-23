//
//  PersonalExpenseViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/19/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "PersonalExpenseViewController.h"
#import "AppDelegate.h"
#import "Expense+CoreDataProperties.h"
#import "DayExpenses+CoreDataProperties.h"
#import "MonthExpenses+CoreDataProperties.h"
#import "GraphViewController.h"

@interface PersonalExpenseViewController ()
{
    UIDatePicker *datepicker;
    
            float foodTotal;
            float healthCare;
            float automobile;
            float family;
            float insurance;
            float entertainment;
            float loans;
            float travels;
            float tax;
            float other;
        

}

@end

@implementation PersonalExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentMonth = [NSDate date];
    [self MonthPicker];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [self MonthPicker];
}



-(void)MonthPicker {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [formatter stringFromDate:self.currentMonth];
    self.monthTF.text = dateString;
    [self fetchMonthExpensesData:_currentMonth];
    [self fetchDayExpensesData:_currentMonth];
    
    
    datepicker = [[UIDatePicker alloc]init];
    datepicker.datePickerMode = UIDatePickerModeDate;
    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.monthTF.inputView = datepicker;
}

-(void)dateChanged: (id)sender {
    
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.currentMonth = [picker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString* dateString = [formatter stringFromDate:self.currentMonth];
    self.monthTF.text = dateString;
    
    
    [self fetchMonthExpensesData:self.currentMonth];
    [self fetchDayExpensesData:self.currentMonth];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSManagedObjectContext *)getContext {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;
}

#pragma -mark fetchExpensesData
- (void)fetchMonthExpensesData:(NSDate*)date {
    self.monthExpensesData = [self getMonthExpensesAtDate:date];
    
    float total = 0;
     foodTotal = 0;
     healthCare = 0;
     automobile = 0;
     family = 0;
     insurance = 0;
     entertainment = 0;
     loans = 0;
     travels = 0;
     tax = 0;
     other = 0;
    for (DayExpenses *day in _monthExpensesData.monthExpenses) {
        
        for (Expense *exp in day.expenses) {
            
            total = total + exp.amount.floatValue;
            
            if ([exp.type isEqualToString:@"Food"]) {
                
                foodTotal = foodTotal + exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Health Care"]) {
                
                healthCare = healthCare +exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Family"]) {
                
                family = family + exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Insurance"]) {
                
                insurance = insurance + exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Loans"]) {
                
                loans = loans + exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Entertainment"]) {
                
                entertainment = entertainment + exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Tax"]) {
                
                tax = tax + exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Other"]) {
                
                other = other + exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Automobile"]) {
                
                automobile = automobile + exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Travels"]) {
                
                travels = travels + exp.amount.floatValue;
            }
        }
    }
    
    self.monthExpenseLb.text = [NSString stringWithFormat:@"%f", total];
    self.foodLb.text = [NSString stringWithFormat:@"%f", foodTotal];
    self.healthCareLb.text = [NSString stringWithFormat:@"%f", healthCare];
    self.familyLb.text = [NSString stringWithFormat:@"%f", family];
    self.travelsLb.text = [NSString stringWithFormat:@"%f", travels];
    self.automobileLb.text = [NSString stringWithFormat:@"%f", automobile];
    self.taxLb.text = [NSString stringWithFormat:@"%f", tax];
    self.loansLb.text = [NSString stringWithFormat:@"%f", loans];
    self.otherLb.text = [NSString stringWithFormat:@"%f", other];
    self.entertainmentLb.text = [NSString stringWithFormat:@"%f", entertainment];
    self.insuranceLb.text = [NSString stringWithFormat:@"%f", insurance];
    
    [self saveData];
}

- (MonthExpenses*)getMonthExpensesAtDate:(NSDate*)date {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MM-YYYY"];
    NSString* dateStr = [formatter stringFromDate:date];
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"MonthExpenses"];
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"monthDate == %@", dateStr];
    [desFetctRequest setPredicate:issuePredicate];
    NSError *error = nil;
    NSArray *results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    
    MonthExpenses* monthExpensesData;
    if (results.count > 0) {
        monthExpensesData = [results objectAtIndex:0];
    } else {
        monthExpensesData = [NSEntityDescription insertNewObjectForEntityForName:@"MonthExpenses" inManagedObjectContext:[self getContext]];
        monthExpensesData.monthDate = dateStr;
    }
    
    
    return monthExpensesData;
}

- (void)fetchDayExpensesData:(NSDate*)date {
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [formatter stringFromDate:date];
    
    
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"DayExpenses"];
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"date == %@", dateString];
    [desFetctRequest setPredicate:issuePredicate];
    NSError *error = nil;
    NSArray *results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    
    DayExpenses* dayExpense;
    if (results.count > 0) {
        dayExpense = [results objectAtIndex:0];
    } else {
        dayExpense = [NSEntityDescription insertNewObjectForEntityForName:@"DayExpenses" inManagedObjectContext:[self getContext]];
        dayExpense.date = dateString;
        
        MonthExpenses *month = [self getMonthExpensesAtDate:date];
        [month addMonthExpensesObject:dayExpense];
    }
    
    float total = 0;
    for (Expense *expense in dayExpense.expenses ) {
        total = total + expense.amount.floatValue;
    }
    self.todayExpenseLb.text = [NSString stringWithFormat:@"%f", total];
    
    [self saveData];
}

#pragma -mark SaveData
-(void)saveData {
    
    NSError *error = nil;
    if (![[self getContext] save:&error]) {
        NSLog(@"Data not saved");
    }
    else{
        NSLog(@"data is saved");
    }
    
}


- (IBAction)ChartButton:(id)sender {
}

- (IBAction)TapGestrure:(id)sender {
    [self.monthTF resignFirstResponder];
}
/*
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"chart"]) {
        GraphViewController *vc = [segue destinationViewController];
        vc.foodTotal = foodTotal;
        vc.healthCare = healthCare;
        vc.automobile = automobile;
        vc.loans = loans;
        vc.entertainment = entertainment;
        vc.family = family;
        vc.insurance = insurance;
        vc.other = other;
        vc.travels = travels;
        vc.tax = tax;
    }
} */
@end
