//
//  HCChallengeCommunicationController.h
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLCommunicationController.h"
#import "HCChallengeNetworkService.h"

@interface HCChallengeCommunicationController : NLCommunicationController

@property (nonatomic, strong) HCChallengeNetworkService *challengeNetworkService;

@end
