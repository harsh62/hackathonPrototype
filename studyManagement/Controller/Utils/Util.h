//
//  Util.h
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Util : NSObject

+ (UIColor *) colorFromHexString:(NSString *)hexString;
+ (NSString*)hexStringFromColor:(UIColor*)color;
+(void)hideMenu:(UIView *)menuView;
+(void)hideMenu:(UIView *)menuView withMainView:(UIView *)mainView;
+(void)showMenu:(UIView *)menuView;
+(void)showMenu:(UIView *)menuView withMainView:(UIView *)mainView;
+(void)showMenuTwitter:(UIView *)menuView withY:(float) y;
+(void)hideMenuTwitter:(UIView *)menuView withY:(float) y;

+(void)showMenu:(UIView *)menuView withX:(float) x withY:(float) y;
+(void)hideMenu:(UIView *)menuView withX:(float) x withY:(float) y;

+(NSString *)getDateAgo:(double) timeInterval;

+(NSDate *)getNSDateFromTweet:(NSString *) createdAt;

+(NSString *)getHashTagMatch:(NSDictionary *)homeTeam withExtTeam:(NSDictionary *)extTeam;
+(NSString *)getMainHashTagTeam:(NSDictionary *)team;
+(NSString *)getSearchForThisHomeTeam:(NSDictionary *)homeTeam andThisExtTeam:(NSDictionary *)extTeam;
+(NSString *)getSearchForThisTeam:(NSDictionary *)team;
+(NSString *)getSearchForHomePage:(bool)onlyMainHashtag;
+(NSString *)getSearchForHomePage;
+(NSString *)getLocalDateFromUTCDate:(NSString *)dateUTC withFormat:(NSString *)format;

+(CGPoint)getExtPositionWithX: (float )xPosition andY:(float)yPosition;
+(CGPoint)getExtPositionWithX2: (float )xPosition andY:(float)yPosition;
+(float)getXStartMenu:(UIViewController *)controller;
+(float)getXStartMenu:(UIViewController *)controller isModal:(bool) isModal;
+(BOOL)containsBannishedWord:(NSString *)tweet;

+(NSString *)getDeviceID;

@end
