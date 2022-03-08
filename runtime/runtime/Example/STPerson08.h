//
//  STPerson08.h
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STPerson08 : NSObject
@property (assign, nonatomic) int ID;
@property (assign, nonatomic) int weight;
@property (assign, nonatomic) int age;
@property (copy, nonatomic) NSString *name;
- (void)run;
@end

NS_ASSUME_NONNULL_END
