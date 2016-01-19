//
//  NLDataAccessController.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLDataAccessController.h"

@interface NLDataAccessController ()

@property (nonatomic, strong) NLCommunicationController *communicationController;

@end

@implementation NLDataAccessController

- (instancetype)initWithCommunicationController:(NLCommunicationController *)communicationController
{
    self = [super init];

    if (self)
    {
        self.communicationController = communicationController;
    }

    return self;
}

@end
