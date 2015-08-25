//
//  NLCommunicationControllerProvider.h
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

@import Foundation;

@class NLCommunicationController;

@interface NLCommunicationControllerProvider : NSObject

- (NLCommunicationController *)communicationControllerWithConfigurationDictionary:(NSDictionary *)configurationDictionary;

@end
