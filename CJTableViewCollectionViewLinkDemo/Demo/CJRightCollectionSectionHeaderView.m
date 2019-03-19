//
//  CJRightCollectionSectionHeaderView.m
//  HLJGallery
//
//  Created by TianHe on 2019/3/13.
//

#import "CJRightCollectionSectionHeaderView.h"
#import "Masonry.h"
#import "DeviceInfo.h"

@interface CJRightCollectionSectionHeaderView ()

@property (nonatomic, strong, readwrite) UILabel *titleLab;

@end

@implementation CJRightCollectionSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor grayColor];
        //
        [self addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(12);
            make.top.mas_equalTo(20);
            make.height.mas_equalTo(23);
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

+ (CGFloat)headerHeight{
    return 55;
}

- (void)tapAction:(UITapGestureRecognizer *)tap{
    if (self.headerClickBlock) {
        self.headerClickBlock();
    }
}

#pragma mark - ------ set/get ------
- (UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont boldSystemFontOfSize:16];
        _titleLab.textColor = [UIColor blackColor];
    }
    return _titleLab;
}

@end
