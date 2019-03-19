//
//  HLJGalleryAllTagSectionBgView.m
//  HLJGallery
//
//  Created by TianHe on 2019/3/13.
//

#import "CJRightCollectionSectionBgView.h"

@implementation CJRightCollectionSectionBgView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.cornerRadius = 10;
        self.clipsToBounds = YES;
    }
    return self;
}

@end
