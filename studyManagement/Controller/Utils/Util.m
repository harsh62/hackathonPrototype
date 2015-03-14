//
//  Util.m
//  StrikR
//
//  Created by Rémi Blanc on 23/07/13.
//  Copyright (c) 2013 Mickael Alléon. All rights reserved.
//

#import "Util.h"
#import "Constantes.h"

@implementation Util


+(NSString *)getSearchForHomePage{
    return  [Util getSearchForHomePage:false];
    //@"#yoga AND #pilates AND #yogi";

}


+(CGPoint)getExtPositionWithX: (float )xPosition andY:(float)yPosition{
    return CGPointMake(SOCCER_FIELD_WIDTH - xPosition, SOCCER_FIELD_HEIGHT -yPosition );
}


+(CGPoint)getExtPositionWithX2: (float )xPosition andY:(float)yPosition{
    
    CGPoint p;
    p.x = xPosition + 2 * (SOCCER_FIELD_WIDTH/2);
    
    p.y = (SOCCER_FIELD_HEIGHT -yPosition)*2;
    
    return p;
    
    
    
    
    
}

//+(NSString *)getSearchForHomePage:(bool)onlyMainHashtag{
//     NSLog(@"getSearchForHomePage***** onlyMainHashtag %d", onlyMainHashtag );
//    NSString *currentSearch = @"";
//    
//    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
//    NSArray *teams = [[[InitialSlidingViewController getTeamsJSON] objectForKey:@"teams"] sortedArrayUsingDescriptors:[NSArray arrayWithObject:sort]];
//    for( id team in teams ){
//        NSString *idTeam = [team objectForKey:@"id"];
//        if( [MyFavoriteTeamsViewController isFavorite: idTeam ] ){
//  
//            NSArray *listMatchs = [[InitialSlidingViewController getLiveMatchsJSON] objectForKey:@"list"];
//            for( id matchLive in listMatchs ){
//                NSString *currentHomeId = [matchLive objectForKey:@"team_home"];
//                NSString *currentExtId = [matchLive objectForKey:@"team_ext"];
//                if( [idTeam isEqualToString: currentHomeId] || [idTeam isEqualToString: currentExtId] ){
//                    NSString *searchToAdd = @"";
//                    if( onlyMainHashtag ){
//                        searchToAdd = [Util getMainHashTagTeam: team ];
//                    }else{
//                        searchToAdd = [Util getSearchForThisTeam: team ];
//                    }
//                    if( [currentSearch isEqualToString:@""] ){
//                        currentSearch = searchToAdd;
//                    }else{
//                        currentSearch = [currentSearch stringByAppendingString:[NSString stringWithFormat:@" OR %@",searchToAdd] ];
//                    }
//                    break;
//                }
//            }  
//        }
//    }
//    
//    if( [currentSearch isEqualToString:@""] ){
//        currentSearch = @"#BPL OR #Strikr";
//        //currentSearch = @"#BPL";
//    }
//    
//    currentSearch = [currentSearch stringByAppendingString:[NSString stringWithFormat:@" -include:retweets"] ];
//    
//    /*
//    NSString *bannishedWords = [[InitialSlidingViewController getLaunchJSON] objectForKey:@"bannished_words"];
//    NSArray *words = [bannishedWords componentsSeparatedByString:@","];
//    for (NSString *word in words){
//        NSString *trimmedWord = [word stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
//        currentSearch = [currentSearch stringByAppendingString:[NSString stringWithFormat:@" -\"%@\"", trimmedWord] ];
//    }
//     */
//    
//    
//    NSLog(@"************currentSearch************* size %d %@", [currentSearch length], currentSearch );
//    if(  [currentSearch length]< 500){
//        return currentSearch;
//    }else{
//        return [Util getSearchForHomePage:true];
//    }
//    
//}
//
//+(BOOL)containsBannishedWord:(NSString *)tweet{
//    NSString *bannishedWords = [[InitialSlidingViewController getLaunchJSON] objectForKey:@"bannished_words"];
//    NSArray *words = [bannishedWords componentsSeparatedByString:@","];
//    for (NSString *word in words){
//        
//        NSString *trimmedWord = [word stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
//     /*   NSString *trimmedWord1 = [NSString stringWithFormat:@" %@ ", trimmedWord ];
//        NSString *trimmedWord2 = [NSString stringWithFormat:@" %@.", trimmedWord ];
//        NSString *trimmedWord3 = [NSString stringWithFormat:@" %@,", trimmedWord ];
//        NSString *trimmedWord4 = [NSString stringWithFormat:@" %@(", trimmedWord ];
//        NSString *trimmedWord5 = [NSString stringWithFormat:@" %@)", trimmedWord ];
//        NSString *trimmedWord6 = [NSString stringWithFormat:@" %@?", trimmedWord ];
//        NSString *trimmedWord7 = [NSString stringWithFormat:@" %@!", trimmedWord ];
//        NSString *trimmedWord8 = [NSString stringWithFormat:@" %@-", trimmedWord ];
//        */
//        
//        
//        
//        NSRegularExpression* regex = [NSRegularExpression regularExpressionWithPattern:[NSString stringWithFormat:@"( |^)%@(\\W|_| |$)", trimmedWord ] options:0 error:nil];
//        NSArray* matches = [regex matchesInString:tweet options:0 range:NSMakeRange(0, [tweet length])];
//
//        if ( [matches count] > 0 ){
//            NSLog(@"bannished_words FOUND: %@ in tweet: %@ ", trimmedWord, tweet );
//            return TRUE;
//            break;
//        }
//        
//      /*
//        if (
//            [tweet rangeOfString: trimmedWord1 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord2 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord3 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord4 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord5 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord6 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord7 ].location != NSNotFound ||
//            [tweet rangeOfString: trimmedWord8 ].location != NSNotFound
//
//            ){
//            NSLog(@"bannished_words FOUND: %@ in tweet: %@ ", trimmedWord, tweet );
//            return TRUE;
//            break;
//        }*/
//        
//    }
//    return NO;
//}

+(NSString *)getSearchForThisTeam:(NSDictionary *)team{
    
    NSString *mainHashtag =[Util getMainHashTagTeam:team];
    NSString *currentSearch = mainHashtag;
    NSString *hashtagList = [team objectForKey:@"hashtags" ];
    hashtagList = [hashtagList stringByReplacingOccurrencesOfString:@"," withString:@" "];
    
    NSArray *hashtagTab =  [hashtagList componentsSeparatedByString:@" "];
    NSLog(@" hashtagTab %@ ", hashtagTab );
    hashtagList = @"";
    for( NSString *hash in hashtagTab ){
        NSLog(@" hash %@ ", hash );
     //  NSString  *hash2 = [hash stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@" "]];
        if( ![hash isEqualToString:@"" ] ){
        if( ![hashtagList isEqualToString:@""] ){
            hashtagList = [hashtagList stringByAppendingString: @" OR "];
        }
        hashtagList = [hashtagList stringByAppendingString: hash ];
        }
    }

    
    if( ![hashtagList isEqualToString:@""]){
        currentSearch = [currentSearch stringByAppendingString:[NSString stringWithFormat:@" OR %@", hashtagList] ];
    }
    
     NSLog(@" currentSearch %@ ", currentSearch );
    return currentSearch;
    
   /* hashtagList = [hashtagList stringByReplacingOccurrencesOfString:@"," withString:@" OR "];
    if( ![hashtagList isEqualToString:@""]){
        currentSearch = [currentSearch stringByAppendingString:[NSString stringWithFormat:@" OR %@", hashtagList] ];
    }
    return currentSearch;
    */
}

+(NSString *)getSearchForThisHomeTeam:(NSDictionary *)homeTeam andThisExtTeam:(NSDictionary *)extTeam{

    NSString *hashtagMatch = [ Util getHashTagMatch: homeTeam withExtTeam:extTeam];
    NSString *hashtagsHomeTeam =[Util getSearchForThisTeam:homeTeam];
    NSString *hashtagsExtTeam = [Util getSearchForThisTeam:extTeam];
    
    NSString *currentSearch = [NSString stringWithFormat:@"-include:retweets %@ OR %@ OR %@", hashtagsHomeTeam, hashtagsExtTeam, hashtagMatch];
    
    /*
    NSString *bannishedWords = [[InitialSlidingViewController getLaunchJSON] objectForKey:@"bannished_words"];
    NSArray *words = [bannishedWords componentsSeparatedByString:@","];
    for (NSString *word in words){
        NSString *trimmedWord = [word stringByTrimmingCharactersInSet: [NSCharacterSet whitespaceCharacterSet]];
         currentSearch = [currentSearch stringByAppendingString:[NSString stringWithFormat:@" -\"%@\"", trimmedWord] ];
    }*/

    return currentSearch;
}

+(NSString *)getHashTagMatch:(NSDictionary *)homeTeam withExtTeam:(NSDictionary *)extTeam{
    return [NSString stringWithFormat:@"#%@%@", [[homeTeam objectForKey: @"abbr" ]  uppercaseString], [[extTeam objectForKey:@"abbr"] uppercaseString] ];
}
+(NSString *)getMainHashTagTeam:(NSDictionary *)team{
    return [[team objectForKey: @"main_hashtag"] uppercaseString];
}

+(NSDate *)getNSDateFromTweet:(NSString *) createdAt{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat:@"EEE MMM dd HH:mm:ss +0000 yyyy"];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"en-US"]];
    NSLog(@" ADD tweet at %@  ---  %@", createdAt, [dateFormatter stringFromDate:[dateFormatter dateFromString: createdAt]  ]);
    return [dateFormatter dateFromString: createdAt];
}

+(NSString *)getLocalDateFromUTCDate:(NSString *)dateUTC withFormat:(NSString *)format{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"UTC"]];
    [dateFormatter setDateFormat: format];
    NSDate *nsdateUTC = [dateFormatter dateFromString: dateUTC ];
    NSDate *dateLocal = [nsdateUTC dateByAddingTimeInterval:[[NSTimeZone localTimeZone] secondsFromGMT]];
    return  [dateFormatter stringFromDate:dateLocal ];
}

+(NSString *)getDateAgo:(double) timeInterval{
    NSString *date;
    if (timeInterval < 1)
    {
        date = @"";
    }
    else if (timeInterval <60)
    {
        int diff = round(timeInterval);
        date = [NSString stringWithFormat:@"%ds", diff];
    }
    else if (timeInterval <3600)
    {
        int diff = round(timeInterval / 60);
        date = [NSString stringWithFormat:@"%dm", diff];
    }
    else if (timeInterval < 86400)
    {
        int diff = round(timeInterval / 60 / 60);
        date = [NSString stringWithFormat:@"%dh", diff];
        
    }
    else if (timeInterval < 2629743)
    {
        int diff = round(timeInterval / 60 / 60 / 24);
        date = [NSString stringWithFormat:@"%dd", diff];
    }
    else
    {
        date = @"";
    }
    return date;
}

+(void)hideMenu:(UIView *)menuView withMainView:(UIView *)mainView{
  
    
    
      if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) {
            CGRect startFrame=CGRectMake(0, 0, 320 ,SOCIAL_MENU_SIZE);
          [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [menuView setFrame: startFrame];
                     }
                     completion:^(BOOL finished){
                         [menuView setHidden:YES ];
                         [mainView setHidden:YES];
                     }
           ];
      }else{
          CGRect startFrame=CGRectMake(300, 0, 320 ,SOCIAL_MENU_SIZE);
          [UIView animateWithDuration:0.3f
                                delay:0.0f
                              options:UIViewAnimationOptionCurveEaseOut
                           animations:^{
                               [menuView setFrame: startFrame];
                           }
                           completion:^(BOOL finished){
                               [menuView setHidden:YES ];
                               [mainView setHidden:YES];
                           }
           ];

          
          
      }
    
}


+(void)hideMenu:(UIView *)menuView  withX:(float) x  withY:(float) y{
    
    
       CGRect startFrame=CGRectMake(x, -y -SOCIAL_MENU_SIZE, 320 ,SOCIAL_MENU_SIZE);
         [UIView animateWithDuration:0.3f
                          delay:0.0f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [menuView setFrame: startFrame];
                     }
                     completion:^(BOOL finished){
                         [menuView setHidden:YES ];
                     }
          ];
  }


+(void)hideMenu:(UIView *)menuView{
    [Util hideMenu:menuView withX:0 withY:0];
}

+(float)getXStartMenu:(UIViewController *)controller {
    return [Util getXStartMenu:controller isModal:false];
}

+(float)getXStartMenu:(UIViewController *)controller isModal:(bool) isModal{
    float xShareMenu = 0;
    if ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) ){
        if( UIDeviceOrientationIsPortrait(controller.interfaceOrientation) ){
            xShareMenu = POSITION_X_SHARE_MENU_IPAD_PORTRAIT;
        }else{
            if( isModal ){
                 xShareMenu = POSITION_X_SHARE_MENU_FULLSCREEN;
            }else{
                 xShareMenu = POSITION_X_SHARE_MENU_WITH_TABBAR;
            }
        }
    }
    return xShareMenu;
}


+(void)showMenu:(UIView *)menuView withMainView:(UIView *)mainView{

    [mainView setHidden:NO];
    [menuView setHidden:NO ];
    
    CGRect frame=CGRectMake(0, SOCIAL_MENU_SIZE, 320 ,SOCIAL_MENU_SIZE);
    [UIView animateWithDuration:0.3f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [menuView setFrame: frame];
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
     ];
}


+(void)showMenu:(UIView *)menuView withX:(float) x withY:(float) y{
    [menuView setHidden:NO ];
   
        CGRect frame=CGRectMake(x, -y,320 ,SOCIAL_MENU_SIZE);
        [UIView animateWithDuration:0.3f
                          delay:0.1f
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         [menuView setFrame: frame];
                         
                     }
                     completion:^(BOOL finished){
                         
                     }
         ];

}



+(void)showMenuTwitter:(UIView *)menuView withY:(float) y{
    [menuView setHidden:NO ];

    
    CGRect frameView = menuView.frame;
            //frameView.origin.y = 0;
    
            frameView.origin.x = 100;
            
            
            menuView.frame = frameView;
            CGRect frame=CGRectMake(100,-y, 320 ,SOCIAL_MENU_SIZE);
            [UIView animateWithDuration:0.3f
                                  delay:0.1f
                                options:UIViewAnimationOptionCurveEaseOut
                             animations:^{
                                 [menuView setFrame: frame];
                                 
                             }
                             completion:^(BOOL finished){
                                 
                             }
             ];
            
            
}

+(void)hideMenuTwitter:(UIView *)menuView withY:(float) y{
    
    

            
    CGRect startFrame=CGRectMake(100,-y, 320 ,SOCIAL_MENU_SIZE);
    [UIView animateWithDuration:0.3f
     delay:0.0f
    options:UIViewAnimationOptionCurveEaseOut
                animations:^{
                [menuView setFrame: startFrame];
                    
                             }
                completion:^(BOOL finished){
                    [menuView setHidden:YES ];
                    
                                 
                                 
    }];
            
            
            
     
    
}



+(void)showMenu:(UIView *)menuView{
    
    [Util showMenu:menuView withX:0 withY:0];
}


+ (NSString*)hexStringFromColor:(UIColor*)color{
    NSString *webColor = nil;
    
    // This method only works for RGB colors
    if (color &&
        CGColorGetNumberOfComponents(color.CGColor) == 4)
    {
        // Get the red, green and blue components
        const CGFloat *components = CGColorGetComponents(color.CGColor);
        
        // These components range from 0.0 till 1.0 and need to be converted to 0 till 255
        CGFloat red, green, blue;
        red = roundf(components[0] * 255.0);
        green = roundf(components[1] * 255.0);
        blue = roundf(components[2] * 255.0);
        
        // Convert with %02x (use 02 to always get two chars)
        webColor = [[NSString alloc]initWithFormat:@"%02x%02x%02x", (int)red, (int)green, (int)blue];
    }
    
    return webColor;
}



+ (UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (NSString *) getDeviceID{
    
    //return [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    NSString* uniqueIdentifier = nil;
    if( [UIDevice instancesRespondToSelector:@selector(identifierForVendor)] ) { // >=iOS 7
        uniqueIdentifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString];
    } else { //<=iOS6, Use UDID of Device
        CFUUIDRef uuid = CFUUIDCreate(NULL);
        //uniqueIdentifier = ( NSString*)CFUUIDCreateString(NULL, uuid);- for non- ARC
        uniqueIdentifier = ( NSString*)CFBridgingRelease(CFUUIDCreateString(NULL, uuid));// for ARC
        CFRelease(uuid);
    }
    
    return uniqueIdentifier;
}


@end
