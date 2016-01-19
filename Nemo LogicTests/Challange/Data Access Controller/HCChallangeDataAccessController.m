//
//  HCChallangeDataAccessController.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "HCChallangeDataAccessController.h"
#import "HCChallangeCommunicationController.h"

@interface HCChallangeDataAccessController ()

@property (nonatomic, strong) HCChallangeCommunicationController *communicationController;

@end

@implementation HCChallangeDataAccessController

- (instancetype)initWithCommunicationController:(NLCommunicationController *)communicationController
{
    self = [super initWithCommunicationController:communicationController];

    if (self)
    {
        NSLog(@"Data Access Controller initialized");
    }

    return self;

}
@end
