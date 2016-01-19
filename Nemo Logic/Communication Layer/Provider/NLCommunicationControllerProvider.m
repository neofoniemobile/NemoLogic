//
//  NLCommunicationControllerProvider.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLCommunicationControllerProvider.h"
#import "NLCommunicationController.h"
#import "NLNetworkService.h"
#import "NLNetworkServiceProvider.h"
#import "NLConfigurationDictionaryKeys.h"

@interface NLCommunicationControllerProvider ()

@property (nonatomic, strong) NSMutableDictionary *communicationControllerStore;
@property (nonatomic, strong) NLNetworkServiceProvider *networkServiceProvider;

@end

@implementation NLCommunicationControllerProvider

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.communicationControllerStore = [[NSMutableDictionary alloc] init];
        self.networkServiceProvider = [[NLNetworkServiceProvider alloc] init];
    }

    return self;
}

- (NLCommunicationController *)communicationControllerWithConfigurationDictionary:(NSDictionary *)configurationDictionary
{
    NSString *communicationControllerName = configurationDictionary[NLClassNameConfigurationKey];
    NLCommunicationController *communicationController = [self.communicationControllerStore objectForKey:communicationControllerName];

    if (!communicationController && communicationControllerName)
    {
        NSArray *services = configurationDictionary[NLServicesConfigurationKey];

        communicationController = [[NSClassFromString(communicationControllerName) alloc] init];

        for (NSDictionary *serviceDictionary in services)
        {
            NSString *propertyName = serviceDictionary[NLServicePropertyNameConfigurationKey];

            if (propertyName && [communicationController respondsToSelector:NSSelectorFromString(propertyName)])
            {
                NLNetworkService *service = [self.networkServiceProvider networkServiceWithConfigurationDictionary:serviceDictionary];
                [communicationController setValue:service forKey:propertyName];
            }
        }
    }

    return communicationController;
}

@end
