//
//  HCNetworkController.h
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

@import Foundation;

@interface NLNetworkService : NSObject

@property (nonatomic, strong) NSDictionary *configurationDictionary;

- (instancetype)initWithConfigurationDictionary:(NSDictionary *)configurationDictionary;

@end
