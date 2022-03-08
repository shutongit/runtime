//
//  main.m
//  RuntimeMethodCache
//
//  Created by 舒通 on 2022/3/8.
//

#import <Foundation/Foundation.h>
#import "MJGoodStudent.h"
#import "MJClassInfo.h"



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        MJGoodStudent *goodStudent = [[MJGoodStudent alloc]init];
        [goodStudent goodStudentTest];
        [goodStudent studentTest];
        [goodStudent personTest];
        [goodStudent goodStudentTest];
        [goodStudent studentTest];
        
        NSLog(@"--------------------------");
        
        mj_objc_class *goodStudentClass = (__bridge mj_objc_class *)[MJGoodStudent class];
        cache_t cache = goodStudentClass->cache;
        NSLog(@"%@, %p", NSStringFromSelector(@selector(personTest)), cache.imp(@selector(personTest)));
        NSLog(@"%@, %p", NSStringFromSelector(@selector(studentTest)), cache.imp(@selector(studentTest)));
        NSLog(@"%@, %p", NSStringFromSelector(@selector(goodStudentTest)), cache.imp(@selector(goodStudentTest)));
    
       
        bucket_t *buckets = cache._buckets;
        bucket_t bucket = buckets[(long)(long)@selector(studentTest) & cache._mask];
        NSLog(@"---- %lu, %p", bucket._key, bucket._imp);
        for (int i = 0; i < cache._mask; i ++) {
            bucket_t item = buckets[i];
            NSLog(@"%lu, %p", item._key, item._imp);
        }
        
        
    }
    return 0;
}
