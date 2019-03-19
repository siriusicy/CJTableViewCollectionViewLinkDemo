//
//  HLJGalleryAllTagDetailCell.h
//  HLJGallery
//
//  Created by TianHe on 2019/3/13.
//

#import <UIKit/UIKit.h>
#import "CJTagModel.h"

@interface CJRightCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) CJTagModel *tagModel;

+ (CGFloat)cellHeightWithWidth:(CGFloat)cellWidth;

@end
