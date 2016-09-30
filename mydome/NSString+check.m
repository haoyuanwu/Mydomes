//
//  NSString+check.m
//  iPoliceClient
//
//  Created by Chance on 15/7/24.
//  Copyright (c) 2015年 济南掌游. All rights reserved.
//

#import "NSString+check.h"

@implementation NSString (check)

- (BOOL)isBlank{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""]) ? YES : NO;
}

- (BOOL)isValid{
    return ([[self removeWhiteSpacesFromString] isEqualToString:@""] || self == nil || [self isEqualToString:@"(null)"]|| [self isEqualToString:@"null"]) ? NO :YES;
}

- (NSString *)removeWhiteSpacesFromString{
    NSString *trimmedString = [self stringByTrimmingCharactersInSet:
                               [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return trimmedString;
}

- (BOOL)isValidEmail{
    NSString *regex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTestPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailTestPredicate evaluateWithObject:self];
}

- (BOOL)isValidPhoneNumber{
    NSString *phoneRegex = @"^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    BOOL isValid = [phoneTest evaluateWithObject:self];
    return isValid;
}

- (BOOL)isValidUrl{
    NSString *regex =@"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [urlTest evaluateWithObject:self];
}

-(BOOL)isValidPassword{
    NSString *Regex = @"^.{3,10}$";
    NSPredicate *passwordTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", Regex];
    return [passwordTest evaluateWithObject:self];
}

@end
