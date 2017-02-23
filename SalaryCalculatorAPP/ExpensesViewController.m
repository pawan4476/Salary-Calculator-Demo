//
//  ExpensesViewController.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/12/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//

#import "ExpensesViewController.h"
#import <CoreData/CoreData.h>
#import "Expense+CoreDataProperties.h"
#import "DayExpenses+CoreDataProperties.h"
#import "MonthExpenses+CoreDataProperties.h"
#import "AppDelegate.h"

#define ADD_TAG 100
#define EDIT_TAG 101
@interface ExpensesViewController ()
{
    NSIndexPath *indexpath;
    UIAlertController *customAlert;
   // NSArray *result2;
    Expense *editingObjct;
}

@end

@implementation ExpensesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.currentDate = [NSDate date];
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [formatter stringFromDate:self.currentDate];
    self.dateTF.text = dateString;
    [self fetchDayExpensesData:self.currentDate];
    
    
    self.datepicker = [[UIDatePicker alloc]init];
    self.datepicker.datePickerMode = UIDatePickerModeDate;
    [self.datepicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    self.dateTF.inputView = self.datepicker;
    
    
        
    self.picker = [[UIPickerView alloc]init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
    self.typeTF.inputView = self.picker;
    self.types = Categories;
 
    _addButton.tag = ADD_TAG;
}


#pragma -mark getContext
-(NSManagedObjectContext *)getContext {
    
    AppDelegate *appDelegate = (AppDelegate *) [UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = appDelegate.persistentContainer.viewContext;
    return context;
    
}



#pragma -mark fetchExpensesData
- (void)fetchDayExpensesData:(NSDate*)date {
    
    NSDateFormatter *formatter  = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString *dateString = [formatter stringFromDate:date];
    
    
    NSFetchRequest * desFetctRequest = [NSFetchRequest fetchRequestWithEntityName:@"DayExpenses"];
    NSPredicate *issuePredicate = [NSPredicate predicateWithFormat:@"date == %@", dateString];
    [desFetctRequest setPredicate:issuePredicate];
    NSError *error = nil;
    NSArray *results = [[self getContext] executeFetchRequest:desFetctRequest error:&error];
    
    if (results.count > 0) {
        self.currentExpensesData = [results objectAtIndex:0];
    } else {
        self.currentExpensesData = [NSEntityDescription insertNewObjectForEntityForName:@"DayExpenses" inManagedObjectContext:[self getContext]];
        self.currentExpensesData.date = dateString;
        
        MonthExpenses *month = [self getMonthExpensesAtDate:date];
        [month addMonthExpensesObject:self.currentExpensesData];
    }
    
    [self totalAmount];
    [self saveData];
    [_myTableView reloadData];
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
    
    [self saveData];
    
    return monthExpensesData;
}

#pragma -mark totalAmount
-(void)totalAmount {
    
    int total = 0;
    for (Expense *result in self.currentExpensesData.expenses ) {
        total = total + result.amount.intValue;
    }
    self.totalExpensesLb.text = [NSString stringWithFormat:@"TotalSum:%d", total];
 }




#pragma -mark dateChanged
-(void)dateChanged: (id)sender {
    
    UIDatePicker *picker = (UIDatePicker *)sender;
    self.currentDate = [picker date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString* dateString = [formatter stringFromDate:self.currentDate];
    self.dateTF.text = dateString;
    [self fetchDayExpensesData:self.currentDate];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
   // textField.text = self.dateTF.text;
    
  //  [self.dateTF resignFirstResponder];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self.rupeesTF resignFirstResponder];
  //  [self.noteTextview resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark  UIPickerView
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.types.count;
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.types[row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    self.typeTF.text = self.types[row];
    //[self.typeTF resignFirstResponder];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

#pragma -mark  UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.currentExpensesData.expenses.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    Expense *obj = [self.currentExpensesData.expenses objectAtIndex:indexPath.row];
    
    cell.textLabel.text = obj.type;
    cell.detailTextLabel.text = obj.amount;
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    Expense *obj = [self.currentExpensesData.expenses objectAtIndex:indexPath.row];
//    self.typeTF.text = obj.type;
//    self.rupeesTF.text = obj.amount;
//    self.noteTF.text = obj.notes;
////    obj.type = self.typeTF.text;
////    obj.amount = self.rupeesTF.text;
////    obj.notes = self.noteTF.text;
//
//    
//}

- (nullable NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction* editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        [self editExpense:indexPath];
        
        [tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    
    UITableViewRowAction* deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete" handler:^(UITableViewRowAction * _Nonnull action, NSIndexPath * _Nonnull indexPath) {
        
        [self deleteExpense:indexPath];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    deleteAction.backgroundColor = [UIColor redColor];
    
    return @[editAction, deleteAction];
}

//-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        
//        Expense *managedObject = [self.currentExpensesData.expenses objectAtIndex:indexPath.row];
//        [[self getContext] deleteObject:managedObject];
//        NSError *error = nil;
//        [[self getContext] save:&error];
//
//        [self totalAmount];
//        
//        [self.currentExpensesData removeExpensesObject:managedObject];
//        [self.myTableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        
//        }
//
//    
//}


#pragma -mark AddButton
- (IBAction)AddButton:(UIButton*)sender {
    
    if (sender.tag == EDIT_TAG) {
        editingObjct.type = self.typeTF.text;
        editingObjct.amount = self.rupeesTF.text;
        editingObjct.date = self.dateTF.text;
        editingObjct.notes = self.noteTextview.text;
        
        [_addButton setTitle:@"Add" forState:UIControlStateNormal];
        _addButton.tag = ADD_TAG;
        
    } else {
        NSManagedObjectContext *context = [self getContext];
        Expense *object = [NSEntityDescription insertNewObjectForEntityForName:@"Expense"inManagedObjectContext:context];
        object.type = self.typeTF.text;
        object.amount = self.rupeesTF.text;
        object.date = self.dateTF.text;
        object.notes = self.noteTextview.text;
        
        [self.currentExpensesData addExpensesObject:object];
    }
    
    
    [self saveData];
    [self.myTableView reloadData];
    [self totalAmount];
    
    self.typeTF.text = @"";
    self.rupeesTF.text = @"";
    self.noteTextview.text = @"";
    
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

#pragma -mark PreviousButton
- (IBAction)PreviousButton:(id)sender {
    
    self.typeTF.text = @"";
    self.rupeesTF.text = @"";
    self.noteTextview.text = @"";
    
    self.currentDate = [self.currentDate dateByAddingTimeInterval:-24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString* dateString = [formatter stringFromDate:self.currentDate];
    self.dateTF.text = dateString;
    
    [self fetchDayExpensesData:self.currentDate];
    
    
}

#pragma -mark NextButton
- (IBAction)NextButton:(id)sender {
    
    self.typeTF.text = @"";
    self.rupeesTF.text = @"";
    self.noteTextview.text = @"";
    
    self.currentDate = [self.currentDate dateByAddingTimeInterval:24*60*60];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"dd-MM-YYYY"];
    NSString* dateString = [formatter stringFromDate:self.currentDate];
    self.dateTF.text = dateString;
    
    [self fetchDayExpensesData:self.currentDate];
}

#pragma -mark TapGesture
- (IBAction)TapGesture:(id)sender {
    
    [self.dateTF resignFirstResponder];
    [self.typeTF resignFirstResponder];
    [self.rupeesTF resignFirstResponder];
    [self.noteTextview resignFirstResponder];
    
    
}

//- (IBAction)NoteButton:(id)sender {
//    
//    UIStoryboard *board = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    ViewController2 *vc = [board instantiateViewControllerWithIdentifier:@"ViewController2"];
//    vc.modalPresentationStyle = UIModalPresentationFormSheet;
//    vc.currentExpensesData = self.currentExpensesData;
//    [self presentViewController:vc animated:YES completion:nil];
//    
//}

- (void)editExpense:(NSIndexPath *)path {
    
    editingObjct = [self.currentExpensesData.expenses objectAtIndex:path.row];
    self.typeTF.text = editingObjct.type;
    self.rupeesTF.text = editingObjct.amount;
    self.noteTextview.text = editingObjct.notes;
    
    [_addButton setTitle:@"Update" forState:UIControlStateNormal];
    _addButton.tag = EDIT_TAG;
}

- (void)deleteExpense:(NSIndexPath *)path {
    Expense *managedObject = [self.currentExpensesData.expenses objectAtIndex:path.row];
    [[self getContext] deleteObject:managedObject];
    NSError *error = nil;
    [[self getContext] save:&error];
    
    [self totalAmount];
    
    [self.currentExpensesData removeExpensesObject:managedObject];
}


@end
