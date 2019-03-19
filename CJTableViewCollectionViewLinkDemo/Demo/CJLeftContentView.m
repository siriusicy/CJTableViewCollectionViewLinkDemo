//
//  HLJGalleryAllTagIndexView.m
//  HLJGallery
//
//  Created by TianHe on 2019/3/12.
//

#import "CJLeftContentView.h"
#import "Masonry.h"
#import "DeviceInfo.h"
//cell
#import "CJLeftTableViewCell.h"

@interface CJLeftContentView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong, readwrite) UITableView *tableView;

@end

@implementation CJLeftContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.tableView];
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(UIEdgeInsetsZero);
        }];
 
    }
    return self;
}

#pragma mark - ------ TableViewDelegate ------
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.tagArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CJLeftTableViewCell cellHeight];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CJLeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CJLeftTableViewCell class])];
    if (!cell) {
        cell = [[CJLeftTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([CJLeftTableViewCell class])];
    }
    
    if (indexPath.section == self.currentSelectSection) {
        cell.cellType = AllTagIndexCellTypeSelected;
    }else if (indexPath.section == self.currentSelectSection-1) {
        cell.cellType = AllTagIndexCellTypeBottomCorner;
    }else if (indexPath.section == self.currentSelectSection+1) {
        cell.cellType = AllTagIndexCellTypeTopCorner;
    }else{
        cell.cellType = AllTagIndexCellTypeNormal;
    }

    CJTagModel *tagModel = self.tagArray[indexPath.section];
    cell.titleLab.text = tagModel.tagName;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    self.currentSelectSection = indexPath.section;
    [self.tableView reloadData];
    
    if (self.didSelectedSectionBlock) {
        self.didSelectedSectionBlock(self.currentSelectSection);
    }
}

#pragma mark - ------ set/get ------

- (void)setTagArray:(NSArray<CJTagModel *> *)tagArray{
    _tagArray = tagArray;
    
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.backgroundColor = [UIColor clearColor];

        _tableView.delegate = self;
        _tableView.dataSource = self;

    }
    return _tableView;
}

@end
