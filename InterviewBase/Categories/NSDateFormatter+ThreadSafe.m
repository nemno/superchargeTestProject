//
//  NSDateFormatter+ThreadSafe.m
//  InterViewBase
//
//

#import "NSDateFormatter+ThreadSafe.h"

@implementation NSDateFormatter (ThreadSafe)


+ (NSDateFormatter *)cachedDateFormatter {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:@"cachedDateFormatter"];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat: @"YYYY-MM-dd HH:mm:ss"];
        [threadDictionary setObject:dateFormatter forKey:@"cachedDateFormatter"];
    }
    
    return dateFormatter;
}

+ (NSDateFormatter *)cachedDateFormatterForDateFormat:(NSString *)dateFormat {
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:dateFormat];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        [threadDictionary setObject:dateFormatter forKey:dateFormat];
    }
    
    return dateFormatter;
}

+ (NSDateFormatter *)cachedDateFormatterForDateFormat:(NSString *)dateFormat withLocale:(NSString *)locale {
    NSString *key = [NSString stringWithFormat:@"%@%@", dateFormat, locale];
    NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
    NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
    if (dateFormatter == nil) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateFormat:dateFormat];
        
        NSLocale *localeObject = [[NSLocale alloc] initWithLocaleIdentifier:locale];
        
        if (locale) {
            [dateFormatter setLocale:localeObject];
        }
        
        [threadDictionary setObject:dateFormatter forKey:key];
    }
    
    return dateFormatter;
}

+ (NSDate *)dateFromString:(NSString *)dateString {
    NSDateFormatter *formater = [NSDateFormatter cachedDateFormatter];
    return [formater dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date {
    NSDateFormatter *formater = [NSDateFormatter cachedDateFormatter];
    return [formater stringFromDate:date];
}

+ (NSDate *)dateFromString:(NSString *)dateString forDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [NSDateFormatter cachedDateFormatterForDateFormat:dateFormat];
    return [formater dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date forDateFormat:(NSString *)dateFormat {
    NSDateFormatter *formater = [NSDateFormatter cachedDateFormatterForDateFormat:dateFormat];
    return [formater stringFromDate:date];
}

+ (NSString *)localizedStringFromDate:(NSDate *)date forDateFormat:(NSString *)dateFormat withLoclale:(NSString *)locale {
    NSDateFormatter *formater = [NSDateFormatter cachedDateFormatterForDateFormat:dateFormat withLocale:locale];
     return [formater stringFromDate:date];
}

@end
