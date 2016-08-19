//
//  UserInfo.m
//  MobilitymyPractics
//
//  Created by Saurabh on 8/8/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
{
    NSDictionary *serverConfig;
}
static NSString * const kConfigurationKey = @"com.apple.configuration.managed";

+(instancetype)shareUserInfo
{
    static UserInfo *_shareUserInfo = nil;
    static dispatch_once_t oncetoken;
    _dispatch_once(&oncetoken, ^{
     
        _shareUserInfo = [[UserInfo alloc]init];
    });
    return _shareUserInfo;
}

-(instancetype)init
{
    if (self = [super init]) {
     serverConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];
        if (serverConfig==nil) {
            serverConfig =[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"demoUser" ofType:@"plist"]];
        }
    }
    return self;
}

-(NSDictionary *)getServerConfig
{
    if (!serverConfig) {
        serverConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];

        if (serverConfig == nil) {
           serverConfig =[NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"demoUser" ofType:@"plist"]];
        }
    }


    return serverConfig;
}

-(NSString *)firstName
{
    _firstName = [self getServerConfig][@"firstName"];
    return _firstName;
}


- (NSString *)lastName
{
    _lastName = [self getServerConfig][@"lastName"];
    return _lastName;
}

- (NSString *)cropID
{
    _cropID = [self getServerConfig][@"corpID"];
    return _cropID;
}

- (NSString *)location
{
    _location = [self getServerConfig][@"location"];
    return _location;
}

- (NSString *)emailIDValue
{
    _emailIDValue = [self getServerConfig][@"mail"];
    return _emailIDValue;
}

- (NSString *)serialNo
{
    _serialNo = [self getServerConfig][@"serialNumber"];
    return _serialNo;
}

- (NSString *)fullName
{
    NSString *nameOfPerson;
    
    if (self.firstName && self.lastName)
    {
        nameOfPerson = [self.firstName stringByAppendingString:[NSString stringWithFormat:@" %@",self.lastName]];
    } else if (self.firstName)
    {
        nameOfPerson = self.firstName;
        
    }else if (self.lastName)
    {
        nameOfPerson = self.lastName;
    }
    
    _fullName = nameOfPerson;
    
    return _fullName;
}

- (NSString *)alias
{
    _alias = [self getServerConfig][@"alias"];
    return _alias;
}

- (NSArray *)tags
{
    _tags = [self getServerConfig][@"tags"];
    return _tags;
}

- (NSString *)oKToUpdate
{
    _oKToUpdate = [self getServerConfig][@"ok2updateURL"];
    return _oKToUpdate;
}

- (NSString *)iTSM_LDAP_BaseURL
{
    _iTSM_LDAP_BaseURL = [self getServerConfig][@"ucbAPIURL"];
    return _iTSM_LDAP_BaseURL;
}

- (NSString *)applicationBaseURL
{
    _applicationBaseURL = [self getServerConfig][@"appAPIURL"];
    return _applicationBaseURL;
}

- (NSString *)appStoreURL
{
    _appStoreURL = [self getServerConfig][@"appstoreURL"];
    return _appStoreURL;
}

- (void)userDefaultdValueChanged
{
    serverConfig = [[NSUserDefaults standardUserDefaults] dictionaryForKey:kConfigurationKey];
    
    if (serverConfig == nil)
    {
        NSString *pathOfPlist = [[NSBundle mainBundle] pathForResource:@"DemoUserInfo" ofType:@"plist"];
        serverConfig = [NSDictionary dictionaryWithContentsOfFile:pathOfPlist];
    }
}



@end
