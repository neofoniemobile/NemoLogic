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
#import "HCChallangeManager.h"
#import "HCChallangeDataAccessController.h"
#import "HCChallangeCommunicationController.h"
#import "HCChallangeNetworkService.h"

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
    HCChallangeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallangeManager"];
    HCChallangeDataAccessController *dataAccessController = [manager valueForKey:@"dataAccessController"];
    HCChallangeCommunicationController *communicationController = [dataAccessController valueForKey:@"communicationController"];
    HCChallangeNetworkService *networkService = [communicationController challangeNetworkService];

    XCTAssert([manager isKindOfClass:[HCChallangeManager class]], @"Manager not created");
    XCTAssert([dataAccessController isKindOfClass:[HCChallangeDataAccessController class]], @"Data Access Controller not created");
    XCTAssert([communicationController isKindOfClass:[HCChallangeCommunicationController class]], @"Communication Controller not created");
    XCTAssert([networkService isKindOfClass:[HCChallangeNetworkService class]], @"Network Service not created");
}

- (void)testCorrectPlistWithoutNetwork
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallangeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallangeManagerWithoutNetwork"];
    HCChallangeDataAccessController *dataAccessController = [manager valueForKey:@"dataAccessController"];
    HCChallangeCommunicationController *communicationController = [dataAccessController valueForKey:@"communicationController"];

    XCTAssert([manager isKindOfClass:[HCChallangeManager class]], @"Manager not created");
    XCTAssert([dataAccessController isKindOfClass:[HCChallangeDataAccessController class]], @"Data Access Controller not created");
    XCTAssert(communicationController == nil, @"Communication Controller created");
}

- (void)testPlistWithoutClassName
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallangeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallangeManagerWithoutClassName"];
    XCTAssert(manager == nil, @"Manager created");
}

- (void)testPlistWithoutDataControllerClassName
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];

    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallangeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallangeManagerWithoutDataControllerClassName"];
    XCTAssert([manager valueForKey:@"dataAccessController"] == nil, @"Data access controller created");
}

- (void)testPlistWithoutDataController
{
    NSDictionary *dictionary = [[NSDictionary alloc] initWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"NLManagerProviderTest" ofType:@"plist"]];
    
    [NLManagerProvider setConfigurationDictionary:dictionary];
    [[NLManagerProvider sharedInstance] resetManagers];
    HCChallangeManager *manager = [[NLManagerProvider sharedInstance] managerWithName:@"ChallangeManagerWithoutDataController"];
    XCTAssert([manager valueForKey:@"dataAccessController"] == nil, @"Data access controller created");
}

@end
