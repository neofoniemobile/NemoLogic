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
@property (nonatomic, strong) NLCommunicationController *communicationController;

@end

@implementation NLManager

- (instancetype)initWithDataAccessController:(NLDataAccessController *)dataAccessController communicationController:(NLCommunicationController *)communicationController
{
    self = [super init];

    if (self)
    {
        self.dataAccessController = dataAccessController;
        self.communicationController = communicationController;
    }

    return self;
}

@end
