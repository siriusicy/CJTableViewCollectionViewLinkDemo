//
//  HLJGalleryAllTagDetailSectionHeaderView.h
//  HLJGallery
//
//  Created by TianHe on 2019/3/13.
//

#import <UIKit/UIKit.h>

@interface CJRightCollectionSectionHeaderView : UICollectionReusableView

@property (nonatomic, strong, readonly) UILabel *titleLab;
@property (nonatomic, copy) void(^headerClickBlock)(void);

+ (CGFloat)headerHeight;

@end
