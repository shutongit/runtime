//
//  NSObject+Json.h
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (Json)
+ (instancetype)st_objectWithJson:(NSDictionary *)json;
@end

NS_ASSUME_NONNULL_END
