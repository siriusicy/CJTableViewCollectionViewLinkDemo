//
//  HLJGalleryAllTagIndexCell.m
//  HLJGallery
//
//  Created by TianHe on 2019/3/12.
//

#import "CJLeftTableViewCell.h"
#import "Masonry.h"
#import "DeviceInfo.h"

@interface CJLeftTableViewCell ()

@property (nonatomic, strong) UIView *bgView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong, readwrite) UILabel *titleLab;

@end

@implementation CJLeftTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.contentView.backgroundColor = [UIColor grayColor];
        self.contentView.clipsToBounds = YES;
        
        [self.contentView addSubview:self.bgView];
        [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(-10);
            make.left.mas_equalTo(-10);
            make.right.mas_equalTo(10);
            make.bottom.mas_equalTo(10);
        }];
        
        [self.contentView addSubview:self.lineView];
        [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(0);
            make.centerY.mas_equalTo(0);
            make.width.mas_equalTo(3);
            make.height.mas_equalTo(20);
        }];
        
        [self.contentView addSubview:self.titleLab];
        [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(15);
            make.right.mas_equalTo(-5);
            make.centerY.mas_equalTo(0);
        }];

    }
    return self;
}

+ (CGFloat)cellHeight{
    return 60;
}

#pragma mark - ------ set/get ------
- (void)setCellType:(AllTagIndexCellType)cellType{
    
    self.bgView.backgroundColor = [UIColor whiteColor];
    self.lineView.hidden = YES;
    self.titleLab.textColor = [UIColor blackColor];
    self.titleLab.font = [UIFont systemFontOfSize:15];
    
    switch (cellType) {
        case AllTagIndexCellTypeNormal:{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.left.mas_equalTo(-10);
                make.right.bottom.mas_equalTo(10);
            }];
        }
            break;
        case AllTagIndexCellTypeTopCorner:{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.top.right.mas_equalTo(0);
                make.left.bottom.mas_equalTo(-20);
                make.bottom.mas_equalTo(20);
            }];
        }
            break;
        case AllTagIndexCellTypeBottomCorner:{
            [self.bgView mas_updateConstraints:^(MASConstraintMaker *make) {
                make.bottom.right.mas_equalTo(0);
                make.left.top.mas_equalTo(-20);
            }];
        }
            break;
        case AllTagIndexCellTypeSelected:{
            self.bgView.backgroundColor = [UIColor clearColor];
            self.lineView.hidden = NO;
            self.titleLab.textColor = [UIColor blackColor];
            self.titleLab.font = [UIFont boldSystemFontOfSize:15];
        }
            break;
        default:
            break;
    }
    
}


- (UIView *)bgView{
    if (_bgView == nil) {
        _bgView = [[UIView alloc] init];
        _bgView.backgroundColor = [UIColor whiteColor];
        _bgView.layer.cornerRadius = 10;
        _bgView.clipsToBounds = YES;
    }
    return _bgView;
}

- (UIView *)lineView{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor redColor];
        
        _lineView.layer.cornerRadius = 1.5;
        _lineView.clipsToBounds = YES;
    }
    return _lineView;
}

- (UILabel *)titleLab{
    if (_titleLab == nil) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.font = [UIFont systemFontOfSize:15];
        _titleLab.textColor = [UIColor blackColor];
        _titleLab.text = @"新娘造型";
    }
    return _titleLab;
}
@end
