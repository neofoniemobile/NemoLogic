//
//  HCNetworkControllerProvider.h
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

@import Foundation;

@class NLNetworkService;

@interface NLNetworkServiceProvider : NSObject

- (NLNetworkService *)networkServiceWithConfigurationDictionary:(NSDictionary *)configurationDictionary;

@end
