//
//  CJTagModel.h
//  HLJGallery
//
//  Created by TianHe on 2018/12/3.
//

#import <Foundation/Foundation.h>

@interface CJTagModel : NSObject 

@property (nonatomic, copy) NSString *tagName;
@property (nonatomic, copy) NSString *tagImage;
@property (nonatomic, strong) NSArray<CJTagModel *> *childTagArray;


@end
