//
//  ViewController.m
//  CJTableViewCollectionViewLinkDemo
//
//  Created by TianHe on 2019/3/19.
//  Copyright © 2019 CJ. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "DeviceInfo.h"
//model
#import "CJTagModel.h"
//view
#import "CJLeftContentView.h"
#import "CJRightContentView.h"


#define kIndexViewWidth 90

@interface ViewController ()

@property (nonatomic, strong) NSArray<CJTagModel *> *dataArray;
@property (nonatomic, strong) CJLeftContentView *indexView;
@property (nonatomic, strong) CJRightContentView *detailView;

@property (nonatomic, assign) NSInteger currentSelectSction;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    [self creatData];
    [self setupUI];
}

- (void)creatData{
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithCapacity:20];
    
    for (int i=0; i<20; ++i) {
        CJTagModel *tag = [[CJTagModel alloc] init];
        tag.tagName = [NSString stringWithFormat:@"tag-%d",i];
        
        NSMutableArray *muArr = [NSMutableArray array];
        NSInteger count = rand()%20;
        for (int j=0; j<count; ++j) {
            CJTagModel *childTag = [[CJTagModel alloc] init];
            childTag.tagName = [NSString stringWithFormat:@"childTag-%d",j];
            [muArr addObject:childTag];
        }
        
        tag.childTagArray = [muArr copy];
        
        [tempArr addObject:tag];
    }
    
    self.dataArray = [tempArr copy];
    
}

- (void)setupUI{
    self.indexView.tagArray = self.dataArray;
    self.detailView.tagArray = self.dataArray;
    
    [self.view addSubview:self.indexView];
    [self.indexView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.bottom.mas_equalTo(0);
        make.width.mas_equalTo(kIndexViewWidth);
    }];
    
    [self.view addSubview:self.detailView];
    [self.detailView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(20);
        make.left.mas_equalTo(self.indexView.mas_right);
        make.right.bottom.mas_equalTo(0);
    }];
}
#pragma mark - ------ action ------
- (void)indexViewSelectSection:(NSInteger)section{
    if (self.currentSelectSction == section) {
        return;
    }
    
    self.currentSelectSction = section;
    [self.detailView scrollerToSection:section];
    
}

- (void)detailViewShouldSelectedSection:(NSInteger)section{
    if (self.currentSelectSction == section) {
        return;
    }
    NSLog(@"detailViewShouldSelectedSection");
    self.currentSelectSction = section;
    self.indexView.currentSelectSection = section;
    
    [self.indexView.tableView reloadData];

    //用这个方法让选中的cell居中,不要用scrollToRowAtIndexPath,会抖动
    [self.indexView.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] animated:NO scrollPosition:UITableViewScrollPositionMiddle];

}


#pragma mark - ------ set/get ------
- (CJLeftContentView *)indexView{
    if (_indexView == nil) {
        _indexView = [[CJLeftContentView alloc] init];
        __weak typeof(self) weakSelf = self;
        _indexView.didSelectedSectionBlock = ^(NSInteger section) {
            [weakSelf indexViewSelectSection:section];
        };
    }
    return _indexView;
}

- (CJRightContentView *)detailView{
    if (_detailView == nil) {
        _detailView = [[CJRightContentView alloc] init];
        __weak typeof(self) weakSelf = self;
        _detailView.shouldSelectedSectionBlock = ^(NSInteger section) {
            [weakSelf detailViewShouldSelectedSection:section];
        };
        _detailView.selectHeaderBlock = ^(CJTagModel *tagModel) {

        };
        _detailView.selectItemBlock = ^(CJTagModel *currentTag, CJTagModel *parentTag) {

        };
    }
    return _detailView;
}

@end
