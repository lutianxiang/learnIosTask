//
//  JSONUtils.h
//  Demo04
//
//  Created by 卢天祥 on 2024/7/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JSONUtils : NSObject

+ (void) saveDicJSON:(NSDictionary *)dicData fileName:(NSString *)fileName;
+ (NSDictionary *) loadJSONDic:(NSString *)fileName;

@end

NS_ASSUME_NONNULL_END
