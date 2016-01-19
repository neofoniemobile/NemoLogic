//
//  HCChallangeCommunicationController.h
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLCommunicationController.h"
#import "HCChallangeNetworkService.h"

@interface HCChallangeCommunicationController : NLCommunicationController

@property (nonatomic, strong) HCChallangeNetworkService *challangeNetworkService;

@end
