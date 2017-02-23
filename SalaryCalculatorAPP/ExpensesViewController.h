//
//  ExpensesViewController.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/12/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Expense+CoreDataProperties.h"
#import "DayExpenses+CoreDataProperties.h"

#define Categories [[NSArray alloc]initWithObjects:@"Food", @"Health Care", @"Travels", @"Loans", @"Automobile", @"Entertainment", @"Family", @"Insurance", @"Tax", @"Other", @"Household", nil]
@interface ExpensesViewController : UIViewController<UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (strong, nonatomic) UIDatePicker *datepicker;

@property (strong, nonatomic) UIPickerView *picker;
@property (strong, nonatomic) NSArray *types;

@property (strong, nonatomic) DayExpenses *currentExpensesData;
@property (strong, nonatomic) NSDate *currentDate;
@property (strong, nonatomic) IBOutlet UITextField *typeTF;
@property (strong, nonatomic) IBOutlet UIImageView *rupeesImageView;
@property (strong, nonatomic) IBOutlet UITextField *rupeesTF;
@property (strong, nonatomic) IBOutlet UIButton *addButton;
- (IBAction)AddButton:(id)sender;
//@property (strong, nonatomic) IBOutlet UITextField *noteTF;
@property (weak, nonatomic) IBOutlet UITextView *noteTextview;

@property (strong, nonatomic) IBOutlet UIToolbar *myToolbar;
- (IBAction)PreviousButton:(id)sender;
- (IBAction)NextButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *myTableView;
@property (strong, nonatomic) IBOutlet UILabel *totalExpensesLb;

@property (strong, nonatomic) IBOutlet UIView *myView;
@property (strong, nonatomic) IBOutlet UIScrollView *myScrollView;
@property (strong, nonatomic) IBOutlet UITextField *dateTF;
- (IBAction)TapGesture:(id)sender;
//- (IBAction)NoteButton:(id)sender;

@end
