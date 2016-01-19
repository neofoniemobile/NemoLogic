# Nemo Logic

## Introduction

The Nemo Logic's (NL) main goal is to speed up the architectural development of the projects.

## Architectural aspects

When we create a new application it is mandatory to create a well designed, separated architecture. The NL will provide a layered architecture, with 4 layers. The four layers are the following: 

- Manager
- Data Access Controller
- Communication Layer
- Network Service

### Manager

The manager’s responsibility is to contain all business logic. For example collect and modify the data for the presentation layer. The manager can not contain data operations like create / remove / persist. Each manager has exactly one or zero data access controller on the property called dataAccessController. 

### Data Access Controller 

The data access controller’s responsibility to handle data operations like create / remove / persist. The manager can pass data to the controller to save it, or ask it for cached values. Based on the needs of the project, it can use the persistent store (like Core Data, file system, etc ).

### Communication Controller 

The communication controller will handle all communication requests from the manager. Because each application is different, it can have multiple network service controller for different endpoints. Usually if the manager receive an error, it can use the data access controller to receive the cached value. Otherwise it can pass the received value to the DAO layer to persist it. 

### Network Service 

The network service will handle all network calls.

## Configuration file

To use the NL you have to create a configuration plist file. At the root, there are the managers definitions, which are dictionaries. Each manager has the following format:

- **manager name** - *Dictionary* - The name of the manager
	- **className** *String* - mandatory - The class of the manager. Child class of NLManager. 
	- **communicationController** *Dictionary* - optional - Definition of the communication controller
		- **className** *String* - mandatory - The class of the Communication Controller. Child class of NLCommunicationController
		- **services** *Array* - optional - Definition of the services
			- **className** *String* - mandatory - The class of the Network Service. Child class of NLNetworkService
			- **propertyName**  *String* - mandatory - The name of the property in the communication controller to set the service
			- **networkServiceConfiguration** *Dictionary* - optional - The configuration of the network service. It is passed to the designated initialiser of the network service.
	- **dataAccessController** *Dictionary* - optional - Definition of the data access controller
	 	- **className**  *String* - mandatory - The class of the Data Access Controller. Child class of NLDataAccessController
		

# How to use

To start using Nemo Logic you have to add the Nemo Logic as a pod. Once you have updated the pods, and added the created plist file to the application, you can start using the NL.

To access to a manager, you have to import the NLManagerProvider header file and the requested manager header. After that you can use like this: 

`[[NLManagerProvider sharedInstance] managerWithName:UserManager];`

The name of the manager is added as a const NSString based on the manager name in the configuration file.

The manager provider can accept plist file with different name. In that case you can set the configuration dictionary as a class method:

`[NLManagerProvider setConfigurationDictionary:yourOwnConfigurationDictionary]`

## System Requirements
Nemo Connect requires at least **iOS 6** or **OSX 10.8**. This framework is designed to use ARC.

## Installation 

### CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager, which automates and simplifies the process of using 3rd-party libraries in your projects. To add NemoConnect via CocoaPods, add the following line to your `Podfile`.

```ruby
pod "NemoLogic", "~> 2.0"
```
***


<br />

## License

Nemo Connect is released under the MIT license. See LICENSE file for details.

<br >