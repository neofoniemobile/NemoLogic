//
//  NLTests.m
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "NLManagerProvider.h"
#import "HCChallengeManager.h"
#import "HCChallengeDataAccessController.h"
#import "HCChallengeCommunicationController.h"
#import "HCChallengeNetworkService.h"

@interface NLTests : XCTestCase

@end

@implementation NLTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testManagerConfigurationDictionaryCreation
{
    NLManagerProvider *provider = [NLManagerProvider sharedInstance];
    NSDictionary *dictionary = [provider valueForKey:@"configurationDictionary"];

    XCTAssert(dictionary != nil, @"Configuration dictionary is not created");
}

- (void)testSetManagerConfigurationDictionary
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    NLManagerProvider *provider = [NLManagerProvider sharedInstance];
    NSDictionary *providerDictionary = [provider valueForKey:@"configurationDictionary"];

    XCTAssert([providerDictionary isEqualToDictionary:dictionary], @"Configuration dictionary not setted");
}

- (void)testCorrectPlist
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallengeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallengeManager"];
    HCChallengeDataAccessController *dataAccessController = [manager valueForKey:@"dataAccessController"];
    HCChallengeCommunicationController *communicationController = [manager valueForKey:@"communicationController"];
    HCChallengeNetworkService *networkService = [communicationController challengeNetworkService];

    XCTAssert([manager isKindOfClass:[HCChallengeManager class]], @"Manager not created");
    XCTAssert([dataAccessController isKindOfClass:[HCChallengeDataAccessController class]], @"Data Access Controller not created");
    XCTAssert([communicationController isKindOfClass:[HCChallengeCommunicationController class]], @"Communication Controller not created");
    XCTAssert([networkService isKindOfClass:[HCChallengeNetworkService class]], @"Network Service not created");
}

- (void)testCorrectPlistWithoutNetwork
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallengeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallengeManagerWithoutNetwork"];
    HCChallengeDataAccessController *dataAccessController = [manager valueForKey:@"dataAccessController"];
    HCChallengeCommunicationController *communicationController = [manager valueForKey:@"communicationController"];

    XCTAssert([manager isKindOfClass:[HCChallengeManager class]], @"Manager not created");
    XCTAssert([dataAccessController isKindOfClass:[HCChallengeDataAccessController class]], @"Data Access Controller not created");
    XCTAssert(communicationController == nil, @"Communication Controller created");
}

- (void)testPlistWithoutClassName
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallengeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallengeManagerWithoutClassName"];
    XCTAssert(manager == nil, @"Manager created");
}

- (void)testPlistWithoutDataControllerClassName
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallengeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallengeManagerWithoutDataControllerClassName"];
    XCTAssert([manager valueForKey:@"dataAccessController"] == nil, @"Data access controller created");
}

- (void)testPlistWithoutDataController
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];
    
    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallengeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallengeManagerWithoutDataController"];
    XCTAssert([manager valueForKey:@"dataAccessController"] == nil, @"Data access controller created");
}

@end
