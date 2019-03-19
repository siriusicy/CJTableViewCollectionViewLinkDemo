//
//  HLJGalleryAllTagDetailCell.m
//  HLJGallery
//
//  Created by TianHe on 2019/3/13.
//

#import "CJRightCollectionViewCell.h"
#import "Masonry.h"
#import "DeviceInfo.h"
//
#define kImageScale (57/65.0)

@interface CJRightCollectionViewCell ()

@property (nonatomic, strong) UIImageView *mainImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end

@implementation CJRightCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        
        [self addSubview:self.mainImageView];
        [self.mainImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.right.mas_equalTo(0);
            make.height.mas_equalTo(self.mainImageView.mas_width).multipliedBy(kImageScale);
        }];
        
        [self addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(0);
            make.left.right.mas_equalTo(0);
            make.top.mas_equalTo(self.mainImageView.mas_bottom).offset(8);
        }];
    }
    return self;
}

+ (CGFloat)cellHeightWithWidth:(CGFloat)cellWidth{
    return cellWidth * kImageScale + 25;
}
#pragma mark - ------ set/get ------

- (void)setTagModel:(CJTagModel *)tagModel{
    _tagModel = tagModel;
    
    self.nameLabel.text = tagModel.tagName;
}

- (UIImageView *)mainImageView{
    if (_mainImageView == nil) {
        _mainImageView = [[UIImageView alloc] init];
        _mainImageView.backgroundColor = [UIColor grayColor];
        _mainImageView.layer.borderColor = [UIColor grayColor].CGColor;
        _mainImageView.layer.borderWidth = 1;
        _mainImageView.layer.cornerRadius = 10;
        _mainImageView.clipsToBounds = YES;
    }
    return _mainImageView;
}

- (UILabel *)nameLabel{
    if (_nameLabel == nil) {
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = [UIFont boldSystemFontOfSize:12];
        _nameLabel.textColor = [UIColor blackColor];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.text = @"测试";
    }
    return _nameLabel;
}


@end

