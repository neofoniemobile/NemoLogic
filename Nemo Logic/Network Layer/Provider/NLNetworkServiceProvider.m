//
//  HCNetworkControllerProvider.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLNetworkServiceProvider.h"
#import "NLNetworkService.h"
#import "NLConfigurationDictionaryKeys.h"

@interface NLNetworkServiceProvider ()

@property (nonatomic, strong) NSMutableDictionary *networkControllerStore;

@end

@implementation NLNetworkServiceProvider

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.networkControllerStore = [[NSMutableDictionary alloc] init];
    }

    return self;
}

- (NLNetworkService *)networkServiceWithConfigurationDictionary:(NSDictionary *)configurationDictionary
{
    NSString *className = configurationDictionary[NLClassNameConfigurationKey];
    NLNetworkService *networkController = self.networkControllerStore[className];

    if (!networkController && className)
    {
        networkController = [[NSClassFromString(className) alloc] initWithConfigurationDictionary:configurationDictionary[NLNetworkServiceConfigurationKey]];

        if (networkController)
        {
            [self.networkControllerStore setObject:networkController forKey:className];
        }
    }

    return networkController;
}

@end
