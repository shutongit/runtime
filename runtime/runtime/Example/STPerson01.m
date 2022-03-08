//
//  STPerson.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STPerson01.h"

// 掩码，一般用来按位与(&)运算的
//#define MJTallMask 1
//#define MJRichMask 2
//#define MJHandsomeMask 4

#define MJTallMask 0b00000001
#define MJRichMask 0b00000010
#define MJHandsomeMask 0b00000100

//#define MJTallMask (1<<0)
//#define MJRichMask (1<<1)
//#define MJHandsomeMask (1<<2)


// 0010 1010
//&1111 1101
//----------
// 0010 1000

@interface STPerson01 () {
    char _tallRichHandsome;
}

@end

@implementation STPerson01

- (instancetype)init
{
    self = [super init];
    if (self) {
        _tallRichHandsome = 0b00000100; // 默认tall 1， rich 0， handsome 0
    }
    return self;
}

- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome |= MJTallMask;
    }else {
        _tallRichHandsome &= ~MJTallMask;
    }
}
- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome |= MJRichMask;
    }else {
        _tallRichHandsome &= ~MJRichMask;
    }
}
- (void)setHandsome:(BOOL)handsome {
    if (handsome) {
        _tallRichHandsome |= MJHandsomeMask;
    } else {
        _tallRichHandsome &= ~MJHandsomeMask;
    }
}

- (BOOL)isTall {
    return !!(_tallRichHandsome & MJTallMask);
}
- (BOOL)isRich {
    return !!(_tallRichHandsome & MJRichMask);
}
- (BOOL)isHandsome {
    return !!(_tallRichHandsome & MJHandsomeMask);
}
@end
