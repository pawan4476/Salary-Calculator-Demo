//
//  MonthExpenses+CoreDataProperties.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/27/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "MonthExpenses+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MonthExpenses (CoreDataProperties)

+ (NSFetchRequest<MonthExpenses *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *monthDate;
@property (nullable, nonatomic, retain) NSOrderedSet<DayExpenses *> *monthExpenses;

@end

@interface MonthExpenses (CoreDataGeneratedAccessors)

- (void)insertObject:(DayExpenses *)value inMonthExpensesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromMonthExpensesAtIndex:(NSUInteger)idx;
- (void)insertMonthExpenses:(NSArray<DayExpenses *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeMonthExpensesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInMonthExpensesAtIndex:(NSUInteger)idx withObject:(DayExpenses *)value;
- (void)replaceMonthExpensesAtIndexes:(NSIndexSet *)indexes withMonthExpenses:(NSArray<DayExpenses *> *)values;
- (void)addMonthExpensesObject:(DayExpenses *)value;
- (void)removeMonthExpensesObject:(DayExpenses *)value;
- (void)addMonthExpenses:(NSOrderedSet<DayExpenses *> *)values;
- (void)removeMonthExpenses:(NSOrderedSet<DayExpenses *> *)values;

@end

NS_ASSUME_NONNULL_END
