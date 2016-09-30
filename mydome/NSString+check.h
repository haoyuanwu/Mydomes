//
//  NSString+check.h
//  iPoliceClient
//
//  Created by Chance on 15/7/24.
//  Copyright (c) 2015年 济南掌游. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (check)

- (BOOL)isBlank;
- (BOOL)isValid;
- (BOOL)isValidEmail;
- (BOOL)isValidPhoneNumber;
- (BOOL)isValidUrl;
- (BOOL)isValidPassword;//3-10位
- (NSString *)removeWhiteSpacesFromString;

@end
