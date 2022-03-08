//
//  STPerson02.m
//  runtime
//
//  Created by 舒通 on 2022/3/8.
//

#import "STPerson02.h"

@interface STPerson02 ()
{
    // 位域
    struct {
        char tall : 1; // 占位一个字节
        char rich : 1;
        char handsome : 1;
    } _tallRichHandsome;
}
@end
@implementation STPerson02
- (void)setTall:(BOOL)tall {
    _tallRichHandsome.tall = tall;
}
- (void)setRich:(BOOL)rich {
    _tallRichHandsome.rich = rich;
}
- (void)setHandsome:(BOOL)handsome {
    _tallRichHandsome.handsome = handsome;
}

- (BOOL)isTall {
    return !!_tallRichHandsome.tall;
}
- (BOOL)isRich {
    return !!_tallRichHandsome.rich;
}
- (BOOL)isHandsome {
    return !!_tallRichHandsome.handsome;
}
@end
