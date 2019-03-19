//
//  HLJGalleryAllTagIndexCell.h
//  HLJGallery
//
//  Created by TianHe on 2019/3/12.
//

#import <UIKit/UIKit.h>
#import "CJTagModel.h"

typedef enum : NSUInteger {
    AllTagIndexCellTypeNormal = 0, //默认状态
    AllTagIndexCellTypeTopCorner, //右上圆角
    AllTagIndexCellTypeBottomCorner, //右下圆角
    AllTagIndexCellTypeSelected, //选中
} AllTagIndexCellType;


@interface CJLeftTableViewCell : UITableViewCell

@property (nonatomic, strong, readonly) UILabel *titleLab;
@property (nonatomic, strong) CJTagModel *tagModel;
@property (nonatomic, assign) AllTagIndexCellType cellType;

+ (CGFloat)cellHeight;

@end
