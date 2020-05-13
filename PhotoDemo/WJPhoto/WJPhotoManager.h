//
//  WJPhotoManager.h
//  PhotoDemo
//
//  Created by 贺文杰 on 2020/5/7.
//  Copyright © 2020 贺文杰. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJPhotoManager : NSObject

+ (instancetype)shareInstance;

/// 根据类型获取所有的图片和视频数据
- (void)getSmartAlbum:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType fetchResult:(void(^)(PHFetchResult<PHAsset *> *fetchResult))block;

@end

NS_ASSUME_NONNULL_END
