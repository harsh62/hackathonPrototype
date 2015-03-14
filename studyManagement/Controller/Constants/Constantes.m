//
//  Constantes.m
//  StrikR
//
//  Created by Rémi Blanc on 25/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "Constantes.h"

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@implementation Constantes

NSString *const FONT_CARLSBERG_LIGHT = @"CarlsbergSans-Light";
NSString *const FONT_CARLSBERG_BOLD = @"CarlsbergSans-Bold";
NSString *const FONT_CARLSBERG_BLACK = @"CarlsbergSans-Black";

NSString *const COLOR_CURRENT_DAY = @"049C45";
NSString *const COLOR_LINK_MENU = @"272A2F";
NSString *const COLOR_BACKGROUND_MENU = @"1D2025";
NSString *const COLOR_BACKGROUND_VIEW = @"DBDBDB";
NSString *const COLOR_PLAYER_NO_TWITTER = @"F4f4f4";
NSString *const COLOR_TWITTER_ACTION = @"D3D1C5";
NSString *const COLOR_SEPARATOR = @"E8E8E8";
NSString *const COLOR_LOOSE_POSSESSION = @"959077";
NSString *const COLOR_Midnight_green = @"20372a";
NSString *const COLOR_Vibrant_green =@"009b3a";
NSString *const COLOR_Grey_dark = @"b1b2b3";
NSString *const COLOR_Grey_dataviz = @"dbdbdb";
NSString *const COLOR_Grey_light = @"f4f4f4";
NSString *const COLOR_Grey_tablet = @"bababa";
NSString *const COLOR_Alloy = @"969075";
NSString *const COLOR_Red = @"c60c30";
NSString *const COLOR_Black = @"001201";
NSString *const COLOR_Blue_night= @"1d2025";

NSString *const HEADER_FONT = @"CarlsbergSans-Bold";

float const HEADER_HEIGHT = 33.0f;
float const HEADER_HEIGHT_IPAD = 60.0f;
float const HEADER_TEXT_SIZE = 14;
int const SOCIAL_MENU_SIZE = 250;
int const NB_NEW_TWEET_ON_REFRESH = 50;
int const POSITION_X_SHARE_MENU_IPAD_PORTRAIT = 224;
int const POSITION_X_SHARE_MENU_WITH_TABBAR = 317;
int const POSITION_X_SHARE_MENU_FULLSCREEN = 352;
float const SOCCER_FIELD_WIDTH = 922.0f;
float const SOCCER_FIELD_HEIGHT = 523.0f;

NSString *const CALENDAR_DAY_FONT = @"CarlsbergSans-Black";

NSString *const URL_HOST_TEST = @"carlsberg.boceto.fr";
NSString *const URL_HOST_PREPROD = @"file.rspreprod.fr";
NSString *const URL_HOST_PROD = @"strikr.redshift.fr";
NSString *const URL_FLUX_TEAMS = @"http://{host}/teams/{num_version}";
NSString *const URL_FLUX_MATCH = @"http://{host}/match/{match-id}";
NSString *const URL_FLUX_LIVE = @"http://{host}/live";
NSString *const URL_FLUX_CALENDAR = @"http://{host}/calendar/{num_version}";
NSString *const URL_FLUX_LAUNCH = @"http://{host}/launch/{lang}/{num_version}";
NSString *const URL_FLUX_POLLS = @"http://{host}/poll/{poll-id/response-id}";

NSString *const URL_FLUX_STARTWEET = @"http://{host}/startweet/{num_version}";
NSString *const URL_FLUX_COUNTRY = @"http://{host}/country/{num_version}";
//@"http://file.rspreprod.fr/carlsberg/country.json";

NSString *const TYPE_FLUX_TEAMS = @"teams";
NSString *const TYPE_FLUX_MATCH= @"match";
NSString *const TYPE_FLUX_LIVE= @"live";
NSString *const TYPE_FLUX_CALENDAR= @"calendar";
NSString *const TYPE_FLUX_LAUNCH= @"launch";
NSString *const TYPE_FLUX_POLLS= @"polls";
NSString *const TYPE_FLUX_STARTWEET= @"startweet";
NSString *const TYPE_FLUX_COUNTRY = @"country";

NSString *const FILE_FLUX_COUNTRY = @"country.json";
NSString *const FILE_FLUX_TEAMS = @"teams.json";
NSString *const FILE_FLUX_CALENDAR = @"calendar.json";
NSString *const FILE_FLUX_STARTWEET = @"startweet.json";
NSString *const FILE_FLUX_LAUNCH = @"launch_{lang}.json";

//*********MRAS Constants***********//

NSString *const MRAS_Server_Protocol = @"https://";
NSString *const MRAS_Server_URL = @"neostaging.wsnet.diageo.com/MCAL/MultiChannelWebservice.svc/67225/1.3/MRAS/";
NSString *const MRAS_Server_Age_Gateway = @"Wrapper/CompleteInstallation";
NSString *const Request_Type_Post = @"Post";
NSString *const Request_Type_Get = @"Get";
NSString *const Header_Key_Content_Type=@"Content-Type";
NSString *const Header_Value_For_Key_Content_Type=@"application/json";
NSString *const Header_Key_Proxy_Authorization=@"Proxy-Authorization";
NSString *const Header_Value_For_Key_Proxy_Authorization=@"Basic NjcyMjU6SVNPR1VJTk5ANjcyMjVfMDUwNDIwMTM=";
NSString *const Header_Key_Authorization=@"Authorization";
NSString *const Header_Value_For_Key_Authorization=@"Basic QXNkYXNkQGVtYWlsLmNvbToxOTc4LTAxLTIz";
NSString *const App_ID_Key = @"appId";
NSString *const Gateway_ID_Key = @"gatewayid";
NSString *const Country_Code_Key = @"countryCode";
NSString *const Device_ID_Key = @"deviceId";
NSString *const dateOfBirth_Key = @"dateOfBirth";
NSString *const App_ID_Value = @"67225";
NSString *const Gateway_ID_Value = @"1";

@end
