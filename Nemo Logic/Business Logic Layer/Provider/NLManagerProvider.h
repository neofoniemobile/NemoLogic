//
//  AUManagerProvider.h
//  Nemo Logic
//
//  Copyright (c) 2015 Neofonie Mobile GmbH. All rights reserved.
//  See LICENSE.txt for this framework's licensing information.
//

@import Foundation;

@class NLManager;

@interface NLManagerProvider : NSObject

/*
 * Set the configuration dictionary. If this method is not called, then the provider will search for the plist file based on the classname of itself.
 * @param configurationDictionary: The configuration dictionary
 */
+ (void)setConfigurationDictionary:(NSDictionary *)configurationDictionary;

/*
 * Returns with a manager provider singleton instance.
 */
+ (instancetype)sharedInstance;

/*
 * Returns with a manager with the given name.
 * @param managerName: The name of the manager. It is used in the configuration dictionary
 */
- (id)managerWithName:(NSString *)managerName;

/*
 * Remove all existing managers from the cache.
 */
- (void)resetManagers;

@end
