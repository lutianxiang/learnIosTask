//
//  JSONUtils.m
//  Demo04
//
//  Created by 卢天祥 on 2024/7/17.
//

#import "JSONUtils.h"

@implementation JSONUtils

+ (void)saveDicJSON:(nonnull NSDictionary *)dicData fileName:(nonnull NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dicData options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData) {
        NSLog(@"Error serializing JSON data: %@", error.localizedDescription);
    }
    BOOL success = [jsonData writeToFile:filePath options:NSDataWritingAtomic error:&error];
    if (success) {
        NSLog(@"JSON save success：%@", filePath);
    } else {
        NSLog(@"Error writing JSON data: %@", error.localizedDescription);
    }
}

+ (nonnull NSDictionary *)loadJSONDic:(nonnull NSString *)fileName {
    NSString *path = [[NSBundle mainBundle] bundlePath];
    NSString *filePath = [path stringByAppendingPathComponent:fileName];
    NSData *jsonData = [NSData dataWithContentsOfFile:filePath];
    NSError *error;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error) {
        NSLog(@"JSON read fail：%@", error.localizedDescription);
        return nil;
    }
    if ([jsonObject isKindOfClass:[NSDictionary class]]) {
        return (NSDictionary *)jsonObject;
    }
    NSLog(@"UnKnown Datatype");
    return nil;
}

@end
