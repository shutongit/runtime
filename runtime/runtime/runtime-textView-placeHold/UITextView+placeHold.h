//
//  UITextView+placeHold.h
//  runtime
//
//  Created by 舒通 on 2022/3/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (placeHold)
/// 占位字符串颜色
@property (strong, nonatomic) UIColor *placeHolderColor;
/// 占位字符串
@property (copy, nonatomic) NSString * _Nullable placeHolder;
@end

NS_ASSUME_NONNULL_END
