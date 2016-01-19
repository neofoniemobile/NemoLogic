//
//  AUManager.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLManager.h"
#import "NLDataAccessController.h"

@interface NLManager ()

@property (nonatomic, strong) NLDataAccessController *dataAccessController;

@end

@implementation NLManager

- (instancetype)initWithDataAccessController:(NLDataAccessController *)dataAccessController
{
    self = [super init];

    if (self)
    {
        self.dataAccessController = dataAccessController;
    }

    return self;
}

@end
