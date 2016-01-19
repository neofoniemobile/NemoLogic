//
//  AUManagerProvider.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import "NLManagerProvider.h"
#import "NLManager.h"
#import "NLDataAccessControllerProvider.h"
#import "NLCommunicationController.h"
#import "NLConfigurationDictionaryKeys.h"
#import "NLCommunicationControllerProvider.h"
#import "NLCommunicationController.h"

@interface NLManagerProvider ()

@property (nonatomic, strong) NSMutableDictionary *managerStore;
@property (nonatomic, strong) NSDictionary *configurationDictionary;
@property (nonatomic, strong) NLDataAccessControllerProvider *dataAccessControllerProvider;
@property (nonatomic, strong) NLCommunicationControllerProvider *communicationControllerProvider;

@property (nonatomic, strong) NSLock *lock;

@end

@implementation NLManagerProvider

+ (instancetype)sharedInstance
{
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;

    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });

    return sharedInstance;
}

+ (void)setConfigurationDictionary:(NSDictionary *)configurationDictionary
{
    [[[self class] sharedInstance] setConfigurationDictionary:configurationDictionary];
}

- (instancetype)init
{
    self = [super init];

    if (self)
    {
        self.dataAccessControllerProvider = [[NLDataAccessControllerProvider alloc] init];
        self.communicationControllerProvider = [[NLCommunicationControllerProvider alloc] init];
        self.configurationDictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:NSStringFromClass([self class]) ofType:@"plist"]];
        self.managerStore = [[NSMutableDictionary alloc] init];
        self.lock = [[NSLock alloc] init];
    }

    return self;
}

- (id)managerWithName:(NSString *)managerName
{
    NLManager *manager = [self.managerStore objectForKey:managerName];

    if (!manager)
    {
        [self.lock lock];
        manager = [self.managerStore objectForKey:managerName];

        if (!manager)
        {
            NSDictionary *managerDictionary = self.configurationDictionary[managerName];

            NLDataAccessController *dataAccessController = [self.dataAccessControllerProvider dataAccessControllerWithConfigurationDictionary:managerDictionary[NLDataAccessControllerConfigurationKey]];
            NLCommunicationController *communicationController = [self.communicationControllerProvider communicationControllerWithConfigurationDictionary:managerDictionary[NLCommunicationControllerConfigurationKey]];

            manager = [[NSClassFromString(managerDictionary[NLClassNameConfigurationKey]) alloc] initWithDataAccessController:dataAccessController communicationController:communicationController];

            if (manager)
            {
                [self.managerStore setObject:manager forKey:managerName];
            }

        }
        [self.lock unlock];
    }

    return manager;
}

- (void)resetManagers
{
    [self.managerStore removeAllObjects];
    self.dataAccessControllerProvider = [[NLDataAccessControllerProvider alloc] init];
}

@end
