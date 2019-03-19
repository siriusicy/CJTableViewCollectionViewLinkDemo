//
//  HLJGalleryAllTagDetailView.m
//  HLJGallery
//
//  Created by TianHe on 2019/3/12.
//

#import "CJRightContentView.h"
#import "Masonry.h"
#import "DeviceInfo.h"
//cell
#import "CJRightCollectionViewCell.h"
#import "CJRightCollectionSectionHeaderView.h"
//
#import "CJRightCollectionFlowLayout.h"

#define kTopInsert 20
#define kBottomInsert 20
#define kLingSpace 28

@interface CJRightContentView ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong, readwrite) UICollectionView *collectionView;
@property (nonatomic, assign) BOOL isScrollUp;//是否是向上滚动
@property (nonatomic, assign) CGFloat lastOffsetY;//滚动即将结束时scrollView的偏移量
@property (nonatomic, assign) CGSize cellSize;

@end

@implementation CJRightContentView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor grayColor];
        
        [self addSubview:self.collectionView];
        [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(0);
            make.bottom.mas_equalTo(0);
            make.left.mas_equalTo(12);
            make.right.mas_equalTo(-12);
        }];
        
        CGFloat cellWidth = floor((kScreenWidth - 90 - 30*2 - 15*2)/3.0);
        CGFloat cellHeight = [CJRightCollectionViewCell cellHeightWithWidth:cellWidth];
        self.cellSize = CGSizeMake(cellWidth, cellHeight);
    }
    return self;
}

- (void)scrollerToSection:(NSInteger)section{
    
    CGFloat offsetY = 0;
    
    for (int i = 0; i<section; i++) {
        NSInteger count = [self.collectionView numberOfItemsInSection:i];
        NSInteger lineCount = (count/3) + (count%3>0?1:0);
        offsetY += lineCount*self.cellSize.height ;
        offsetY += (lineCount>1?kLingSpace*(lineCount-1):0) ;
        UIEdgeInsets insert = [self collectionView:self.collectionView layout:self.collectionView.collectionViewLayout insetForSectionAtIndex:i];
        offsetY += insert.top + insert.bottom;
        offsetY += [CJRightCollectionSectionHeaderView headerHeight];
    }

    [_collectionView setContentOffset:CGPointMake(0, offsetY) animated:YES];
     
}

#pragma mark - ------ scrollViewDelegate ------
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

//    NSLog(@"_lastOffsetY : %f,scrollView.contentOffset.y : %f", _lastOffsetY, scrollView.contentOffset.y);
    self.isScrollUp = _lastOffsetY < scrollView.contentOffset.y;
    self.lastOffsetY = scrollView.contentOffset.y;
//    NSLog(@"______lastOffsetY: %f", _lastOffsetY);
}

#pragma mark - ------ collectionViewDelegate ------

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    
    return self.tagArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    NSArray *subTagArray = self.tagArray[section].childTagArray;
    return subTagArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{

    if ([collectionView numberOfItemsInSection:section] > 0) {
        return UIEdgeInsetsMake(kTopInsert, 18, kBottomInsert, 18);
    }else{
        return UIEdgeInsetsMake(0, 18, 0, 18);
    }
}

//header
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(kScreenWidth-90, [CJRightCollectionSectionHeaderView headerHeight]);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        CJRightCollectionSectionHeaderView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind   withReuseIdentifier:NSStringFromClass([CJRightCollectionSectionHeaderView class])   forIndexPath:indexPath];
        
        CJTagModel *tag = self.tagArray[indexPath.section];
        headerView.titleLab.text = tag.tagName;
        headerView.headerClickBlock = ^{

        };

        return headerView;
    }else{
        return [[UICollectionReusableView alloc] init];
    }
}

//cell
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)layout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return self.cellSize;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {

    CJRightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([CJRightCollectionViewCell class]) forIndexPath:indexPath];
    
    NSArray *subTagArray = self.tagArray[indexPath.section].childTagArray;
    cell.tagModel = subTagArray[indexPath.row];
    
    return cell;
    
}

- (void)collectionView:(UICollectionView *)collectionView didEndDisplayingSupplementaryView:(UICollectionReusableView *)view forElementOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader] &&
        self.shouldSelectedSectionBlock &&
        self.isScrollUp == YES &&
        [self.collectionView numberOfSections] > indexPath.section+1 &&
        collectionView.decelerating) {
        
        self.shouldSelectedSectionBlock(indexPath.section+1);
    }
}

- (void)collectionView:(UICollectionView *)collectionView willDisplaySupplementaryView:(UICollectionReusableView *)view forElementKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath{
    
    if ([elementKind isEqualToString:UICollectionElementKindSectionHeader] &&
        self.shouldSelectedSectionBlock &&
        self.isScrollUp == NO &&
        collectionView.contentOffset.y != 0 &&
        collectionView.decelerating) {
        
        self.shouldSelectedSectionBlock(indexPath.section);
    }
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    if (self.selectItemBlock) {

    }
}

#pragma mark - ------ set/get -----

- (void)setTagArray:(NSArray<CJTagModel *> *)tagArray{
    _tagArray = tagArray;
    
    [self.collectionView reloadData];
}

- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        
        CJRightCollectionFlowLayout *flowLayout = [[CJRightCollectionFlowLayout alloc] init];
        flowLayout.sectionBgClassName = @"CJRightCollectionSectionBgView";
        flowLayout.minimumInteritemSpacing = 15;
        flowLayout.minimumLineSpacing = kLingSpace;
//        flowLayout.sectionInset = UIEdgeInsetsMake(kTopInsert, 18, kBottomInsert, 18);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        
        [_collectionView registerClass:[CJRightCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([CJRightCollectionViewCell class])];
        //header
        [_collectionView registerClass:[CJRightCollectionSectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([CJRightCollectionSectionHeaderView class])];
    }
    return _collectionView;
}
@end
