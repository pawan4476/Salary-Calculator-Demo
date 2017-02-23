//
//  GraphViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/26/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "GraphViewController.h"
#import "PNChart.h"
#import "AppDelegate.h"
#import "Expense+CoreDataProperties.h"
#import "DayExpenses+CoreDataProperties.h"
#import "MonthExpenses+CoreDataProperties.h"
#import "DrGraphs.h"
#import "ExpensesViewController.h"

@interface GraphViewController ()<BarChartDataSource, BarChartDelegate>
{
    UIDatePicker *datepicker;
    NSArray* categories;
    
    NSArray* firstMonthValues;
    NSArray* secondMonthValues;
    NSArray* thirdMonthValues;
}


@end

@implementation GraphViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    
    categories = [[NSArray alloc]initWithObjects:@"Food", @"Health Care", @"Travels", @"Loans", @"Automobile", @"Entertainment", @"Family", @"Insurance", @"Tax", @"Other", @"Household", @"Total", nil];
    
    
    self.currentMonth = [NSDate date];
    [self MonthPicker];
    
    [self createBarChart];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _barChartView.frame = CGRectMake(0, BOTTOM(_graphDateTF), WIDTH(self.view), HEIGHT(self.view) - BOTTOM(_graphDateTF));
    
    if (firstMonthValues.count > 0 || secondMonthValues.count > 0 || thirdMonthValues.count > 0) {
        [_barChartView reloadBarGraph];
        
    }
    [self fetchData];
}
- (IBAction)closeButtonClicked:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (BOOL)shouldAutorotate {
    return NO;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationLandscapeLeft;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)MonthPicker {
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [formatter stringFromDate:self.currentMonth];
    self.graphDateTF.text = dateString;
    
    datepicker = [[UIDatePicker alloc]init];
    datepicker.datePickerMode = UIDatePickerModeDate;
    [datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.graphDateTF.inputView = datepicker;
    
    [self fetchData];
}

-(void)dateChanged: (id)sender {
    
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.currentMonth = [picker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString* dateString = [formatter stringFromDate:self.currentMonth];
    self.graphDateTF.text = dateString;
    
    [self fetchData];
}

#pragma -mark fetchExpensesData
-(NSManagedObjectContext *)getContext {
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;
}

- (void) fetchData {
    NSCalendar* cal = [NSCalendar currentCalendar];
    
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    NSDate* date = [cal dateByAddingComponents:dateComponents toDate:_currentMonth options:0];
    thirdMonthValues = [self fetchMonthExpensesData:date];
    
    [dateComponents setMonth:-1];
    date = [cal dateByAddingComponents:dateComponents toDate:_currentMonth options:0];
    secondMonthValues = [self fetchMonthExpensesData:date];
    
    [dateComponents setMonth:-2];
    date = [cal dateByAddingComponents:dateComponents toDate:_currentMonth options:0];
    firstMonthValues = [self fetchMonthExpensesData:date];
    
    [_barChartView reloadBarGraph];
}

- (NSArray *)fetchMonthExpensesData:(NSDate*)date {
    self.monthExpensesData = [self getMonthExpensesAtDate:date];
    
    float total = 0;
    float foodTotal = 0;
    float healthCare = 0;
    float automobile = 0;
    float family = 0;
    float insurance = 0;
    float entertainment = 0;
    float loans = 0;
    float travels = 0;
    float houseHold = 0;
    float tax = 0;
    float other = 0;
    for (DayExpenses *day in _monthExpensesData.monthExpenses) {
        
        for (Expense *exp in day.expenses) {
            
            total += exp.amount.floatValue;
            
            if ([exp.type isEqualToString:@"Food"]) {
                
                foodTotal += exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Health Care"]) {
                
                healthCare += exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Family"]) {
                
                family += exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Insurance"]) {
                
                insurance += exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Loans"]) {
                
                loans += exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Entertainment"]) {
                
                entertainment += exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Tax"]) {
                
                tax += exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Other"]) {
                
                other += exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Automobile"]) {
                
                automobile += exp.amount.floatValue;
                
            }
            
            if ([exp.type isEqualToString:@"Travels"]) {
                
                travels += exp.amount.floatValue;
            }
            
            if ([exp.type isEqualToString:@"Household"]) {
                
                houseHold += exp.amount.floatValue;
            }
        }
    }
    
    [self saveData];
    NSArray* values = @[@(foodTotal), @(healthCare), @(travels), @(loans), @(automobile), @(entertainment), @(family), @(insurance), @(tax), @(other), @(houseHold), @(total)];
    return values;
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

- (IBAction)tapGesture:(id)sender {
    [self.graphDateTF resignFirstResponder];
}

#pragma Mark CreateHorizontalChart
- (void)createBarChart{
    _barChartView = [[BarChart alloc] initWithFrame:CGRectMake(0, BOTTOM(_graphDateTF), WIDTH(self.view), HEIGHT(self.view) - BOTTOM(_graphDateTF))];
    [_barChartView setDataSource:self];
    [_barChartView setDelegate:self];
    [_barChartView setLegendViewType:LegendTypeHorizontal];
    [_barChartView setShowCustomMarkerView:TRUE];
    
    [self.view addSubview:_barChartView];
}


#pragma mark BarChartDataSource
- (NSMutableArray *)xDataForBarChart{
    
    return  categories.mutableCopy;
}

- (NSInteger)numberOfBarsToBePlotted{
    return 3;
}

- (UIColor *)colorForTheBarWithBarNumber:(NSInteger)barNumber{
    
    if (barNumber == 0) {
        return [UIColor redColor];
    } else if (barNumber == 1) {
        return [UIColor greenColor];
    } else {
        return [UIColor blueColor];
    }
}

- (CGFloat)widthForTheBarWithBarNumber:(NSInteger)barNumber{
    return 30;
}

- (NSString *)nameForTheBarWithBarNumber:(NSInteger)barNumber{
    
    NSCalendar* cal = [NSCalendar currentCalendar];
    
    NSDateComponents *offsetComponents = [[NSDateComponents alloc] init];
    if (barNumber == 0) {
        [offsetComponents setMonth:-2];
    } else if (barNumber == 1) {
        [offsetComponents setMonth:-1];
    }
    
    NSDate* date = [cal dateByAddingComponents:offsetComponents toDate:_currentMonth options:0];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"MMMM"];
    NSString* dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}

- (NSMutableArray *)yDataForBarWithBarNumber:(NSInteger)barNumber{
//    NSMutableArray *array = [[NSMutableArray alloc] init];
//    for (int i = 0; i < 20; i++) {
//        [array addObject:[NSNumber numberWithLong:random() % 100]];
//    }
    
    if (barNumber == 0) {
        return firstMonthValues.mutableCopy;
    } else if (barNumber == 1) {
        return secondMonthValues.mutableCopy;
    } else if (barNumber == 2) {
        return thirdMonthValues.mutableCopy;
    }
    return [NSMutableArray array];
}

- (UIView *)customViewForBarChartTouchWithValue:(NSNumber *)value{
    UIView *view = [[UIView alloc] init];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:4.0F];
    [view.layer setBorderWidth:1.0F];
    [view.layer setBorderColor:[[UIColor lightGrayColor] CGColor]];
    [view.layer setShadowColor:[[UIColor blackColor] CGColor]];
    [view.layer setShadowRadius:2.0F];
    [view.layer setShadowOpacity:0.3F];
    
    UILabel *label = [[UILabel alloc] init];
    [label setFont:[UIFont systemFontOfSize:12]];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label setText:[NSString stringWithFormat:@"Bar Data: %@", value]];
    [label setFrame:CGRectMake(0, 0, 100, 30)];
    [view addSubview:label];
    
    [view setFrame:label.frame];
    return view;
}

#pragma mark BarChartDelegate
- (void)didTapOnBarChartWithValue:(NSString *)value{
    NSLog(@"Bar Chart: %@",value);
}

@end
