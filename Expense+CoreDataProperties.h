//
//  Expense+CoreDataProperties.h
//  SalaryCalculatorAPP
//
//  Created by test on 12/27/16.
//  Copyright © 2016 chaitanya. All rights reserved.
//  This file was automatically generated and should not be edited.
//

#import "Expense+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Expense (CoreDataProperties)

+ (NSFetchRequest<Expense *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *amount;
@property (nullable, nonatomic, copy) NSString *date;
@property (nullable, nonatomic, copy) NSString *type;
@property (nullable, nonatomic, copy) NSString *notes;

@end

NS_ASSUME_NONNULL_END
