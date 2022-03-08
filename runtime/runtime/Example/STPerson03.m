//
//  STPerson03.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STPerson03.h"


#define MJTallMask (1<<0)
#define MJRichMask (1<<1)
#define MJHandsomeMask (1<<2)
#define MJThinMask (1<<3)

@interface STPerson03 ()
{
    union { // 共用体
        int bits;
        struct { // 可写可不写，为了方便识别顺序以及占位大小
            char tall : 4;
            char rich : 4;
            char handsome: 4;
            char thin : 4;
        };
    } _tallRichHandsome;
}
@end

@implementation STPerson03
- (void)setTall:(BOOL)tall {
    if (tall) {
        _tallRichHandsome.bits |= MJTallMask;
    } else {
        _tallRichHandsome.bits &= ~MJTallMask;
    }
}
- (BOOL)isTall {
    return !!(_tallRichHandsome.tall & MJTallMask);
}
- (void)setRich:(BOOL)rich {
    if (rich) {
        _tallRichHandsome.bits |= MJRichMask;
    } else {
        _tallRichHandsome.bits &= ~MJRichMask;
    }
}
-(BOOL)isRich {
    return !!(_tallRichHandsome.bits & MJRichMask) ;
}

- (void)setHandsome:(BOOL)handsome
{
    if (handsome) {
        _tallRichHandsome.bits |= MJHandsomeMask;
    } else {
        _tallRichHandsome.bits &= ~MJHandsomeMask;
    }
}

- (BOOL)isHandsome
{
    return !!(_tallRichHandsome.bits & MJHandsomeMask);
}

- (void)setThin:(BOOL)thin
{
    if (thin) {
        _tallRichHandsome.bits |= MJThinMask;
    } else {
        _tallRichHandsome.bits &= ~MJThinMask;
    }
}

- (BOOL)isThin
{
    return !!(_tallRichHandsome.bits & MJThinMask);
}
@end
