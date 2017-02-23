//
//  DayExpenses+CoreDataProperties.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/27/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "DayExpenses+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface DayExpenses (CoreDataProperties)

+ (NSFetchRequest<DayExpenses *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *notes;
@property (nullable, nonatomic, retain) NSOrderedSet<Expense *> *expenses;

@end

@interface DayExpenses (CoreDataGeneratedAccessors)

- (void)insertObject:(Expense *)value inExpensesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromExpensesAtIndex:(NSUInteger)idx;
- (void)insertExpenses:(NSArray<Expense *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeExpensesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInExpensesAtIndex:(NSUInteger)idx withObject:(Expense *)value;
- (void)replaceExpensesAtIndexes:(NSIndexSet *)indexes withExpenses:(NSArray<Expense *> *)values;
- (void)addExpensesObject:(Expense *)value;
- (void)removeExpensesObject:(Expense *)value;
- (void)addExpenses:(NSOrderedSet<Expense *> *)values;
- (void)removeExpenses:(NSOrderedSet<Expense *> *)values;

@end

NS_ASSUME_NONNULL_END
