//
//  UserInfo.h
//  MobilitymyPractics
//
//  Created by Saurabh on 8/8/16.
//  Copyright © 2016 vmoksha. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *fullName;

@property (strong, nonatomic) NSString *cropID;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) NSString *emailIDValue;

@property (strong, nonatomic) NSString *serialNo;

@property (strong, nonatomic) NSArray *tags;
@property (strong, nonatomic) NSString *alias;

@property (strong, nonatomic) NSString *oKToUpdate;
@property (strong, nonatomic) NSString *iTSM_LDAP_BaseURL;
@property (strong, nonatomic) NSString *applicationBaseURL;
@property (strong, nonatomic) NSString *appStoreURL;


+(instancetype)shareUserInfo;
-(NSDictionary *)getServerConfig;

@end
