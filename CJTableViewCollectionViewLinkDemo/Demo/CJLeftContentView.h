//
//  HLJGalleryAllTagIndexView.h
//  HLJGallery
//
//  Created by TianHe on 2019/3/12.
//

#import <UIKit/UIKit.h>

@class CJTagModel;

@interface CJLeftContentView : UIView

@property (nonatomic, strong, readonly) UITableView *tableView;
@property (nonatomic, assign) NSInteger currentSelectSection;
@property (nonatomic, copy) NSArray<CJTagModel *> *tagArray;

@property (nonatomic, copy) void(^didSelectedSectionBlock)(NSInteger section);


@end
