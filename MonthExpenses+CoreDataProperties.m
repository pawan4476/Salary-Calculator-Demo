//
//  MonthExpenses+CoreDataProperties.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/27/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "MonthExpenses+CoreDataProperties.h"

@implementation MonthExpenses (CoreDataProperties)

+ (NSFetchRequest<MonthExpenses *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MonthExpenses"];
}

@dynamic monthDate;
@dynamic monthExpenses;

@end
