//
//  HCNetworkController.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLNetworkService.h"

@implementation NLNetworkService

- (instancetype)initWithConfigurationDictionary:(NSDictionary *)configurationDictionary
{
    self = [super init];

    if (self)
    {
        self.configurationDictionary = configurationDictionary;
    }

    return self;
}

@end
