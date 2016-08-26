//
//  Constant.m
//  UCB_POC
//
//  Created by Saurabh on 8/9/16.
//  Copyright © 2016 Amit. All rights reserved.
//

#import "Constant.h"


@implementation Constant

 //ucb API
// NSString *const EWS_REQUSET_URL_KEY = @"https://mail.ucb.com/ews/exchange.asmx";
// NSString *const EWS_REQUSET_EMAIL_ID = @"#India-Bangalore@ucb.com";
// NSString *const EWS_USERS_PASSWORD =@"ucb@12345";

// vmoksha ExchangeServer api


NSString *const BASE_URL = @"http://prithiviraj.vmokshagroup.com:9033/";

 NSString *const EWS_REQUSET_URL = @"https://10.10.3.156/ews/exchange.asmx";
 NSString *const EWS_REQUSET_EMAIL_ID = @"vmokshabangalore@vmexchange.com";
 NSString *const EWS_REQUSET_USERID = @"user2@vmexchange.com";
 NSString *const EWS_USERS_PASSWORD =@"Power@1234";

NSString *const EWS_REQUSET_USERID_KEY = @"userNameKey";
NSString *const EWS_USERS_PASSWORD_KEY =@"PasswordKey";

NSString *const GET_DETAILS_BEACON_API = @"http://prithiviraj.vmokshagroup.com:9033/Search/Beacons";

NSString *const TIPS_CATEGORY_API = @"http://prithiviraj.vmokshagroup.com:9033/TipsGroups";
NSString *const NEWS_CATEGORY_API =@"http://prithiviraj.vmokshagroup.com:9033/NewsCategories";
NSString *const NEWS_API = @"http://prithiviraj.vmokshagroup.com:9033/Search/News";
NSString *const RENDER_DOC_API = @"http://prithiviraj.vmokshagroup.com:9033/RenderDocument/";

NSString *const LATEST_NEW_ID_API = @"http://prithiviraj.vmokshagroup.com:9033/News/SinceId?Last";

@end
