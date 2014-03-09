//
//  QTPreferences.h
//  QuoteTest
//
//  Created by Nemes Norbert on 3/7/14.
//  Copyright (c) 2014 Norbert Nemes. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kDataHandler [QTDataHandler getInstance]
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height
#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kFloor (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? 64.0f : 0.0f)
#define kStatusBarHeight (([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) ? 0.0f : 20.0f)


//NOTIFICATION NAMES

#define kQouteAddedNotification @"quoteAddedNotification"