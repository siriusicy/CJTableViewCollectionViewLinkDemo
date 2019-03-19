//
//  HLJGalleryAllTagDetailView.h
//  HLJGallery
//
//  Created by TianHe on 2019/3/12.
//

#import <UIKit/UIKit.h>
#import "CJTagModel.h"

@interface CJRightContentView : UIView

@property (nonatomic, strong, readonly) UICollectionView *collectionView;
@property (nonatomic, copy) NSArray<CJTagModel *> *tagArray;
@property (nonatomic, copy) void(^shouldSelectedSectionBlock)(NSInteger section); ///< 联动左侧tableview的block
@property (nonatomic, copy) void(^selectHeaderBlock)(CJTagModel *tagModel);///< header点击
@property (nonatomic, copy) void(^selectItemBlock)(CJTagModel *currentTag,CJTagModel *parentTag);///< item点击

///滚动到
- (void)scrollerToSection:(NSInteger)section;

@end
