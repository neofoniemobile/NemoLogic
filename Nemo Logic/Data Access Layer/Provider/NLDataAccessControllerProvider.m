//
//  NLDataAccessControllerProvider.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLDataAccessControllerProvider.h"
#import "NLDataAccessController.h"
#import "NLCommunicationControllerProvider.h"
#import "NLCommunicationController.h"
#import "NLConfigurationDictionaryKeys.h"

@interface NLDataAccessControllerProvider ()

@property (nonatomic, strong) NSMutableDictionary *dataAccessControllerStore;
@property (nonatomic, strong) NLCommunicationControllerProvider *communicationControllerProvider;

@end

@implementation NLDataAccessControllerProvider

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.dataAccessControllerStore = [[NSMutableDictionary alloc] init];
        self.communicationControllerProvider = [[NLCommunicationControllerProvider alloc] init];
    }

    return self;
}

- (NLDataAccessController *)dataAccessControllerWithConfigurationDictionary:(NSDictionary *)configurationDictionary
{
    NSString *className = configurationDictionary[NLClassNameConfigurationKey];
    NLDataAccessController *dataAccessController = self.dataAccessControllerStore[className];

    if (!dataAccessController && className)
    {
        NLCommunicationController *communicationController = [self.communicationControllerProvider communicationControllerWithConfigurationDictionary:configurationDictionary[NLCommunicationControllerConfigurationKey]];

        dataAccessController = [[NSClassFromString(className) alloc] initWithCommunicationController:communicationController];

        if (dataAccessController)
        {
            [self.dataAccessControllerStore setObject:dataAccessController forKey:className];
        }
    }

    return dataAccessController;
}

@end
