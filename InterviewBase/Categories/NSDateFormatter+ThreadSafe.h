//
//  NSDateFormatter+ThreadSafe.h
//  InterViewBase
//
//

#import <Foundation/Foundation.h>

@interface NSDateFormatter (ThreadSafe)

+ (NSDateFormatter *)cachedDateFormatter;
+ (NSDateFormatter *)cachedDateFormatterForDateFormat:(NSString *)dateFormat;
+ (NSDateFormatter *)cachedDateFormatterForDateFormat:(NSString *)dateFormat withLocale:(NSString *)locale;

+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSDate *)dateFromString:(NSString *)dateString forDateFormat:(NSString *)dateFormat;
+ (NSString *)stringFromDate:(NSDate *)date forDateFormat:(NSString *)dateFormat;

+ (NSString *)localizedStringFromDate:(NSDate *)date forDateFormat:(NSString *)dateFormat withLoclale:(NSString *)locale;

@end
