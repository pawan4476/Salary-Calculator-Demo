//
//  DayExpenses+CoreDataProperties.m
//  SalaryCalculatorAPP
//
//  Created by test on 12/27/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "DayExpenses+CoreDataProperties.h"

@implementation DayExpenses (CoreDataProperties)

+ (NSFetchRequest<DayExpenses *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"DayExpenses"];
}

@dynamic date;
@dynamic notes;
@dynamic expenses;

@end
