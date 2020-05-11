//
//  WJPhotoManager.m
//  PhotoDemo
//
//  Created by 贺文杰 on 2020/5/7.
//  Copyright © 2020 贺文杰. All rights reserved.
//

#import "WJPhotoManager.h"
#import <Photos/Photos.h>

@interface WJPhotoManager ()<PHPhotoLibraryChangeObserver>

@property(nonatomic,strong)PHPhotoLibrary *photoLibrary;

@end

@implementation WJPhotoManager

+ (instancetype)shareInstance
{
    static dispatch_once_t onceToken;
    static WJPhotoManager *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WJPhotoManager alloc] init];
        instance.photoLibrary = [PHPhotoLibrary sharedPhotoLibrary];
    });
    return instance;
}

#warning iOS 10或之后必须要在plist文件中加入NSPhotoLibraryUsageDescription并提供一个值，不然会崩溃

/**
    PHAuthorizationStatusNotDetermined = 0, //用户尚未对该app做出选择
    PHAuthorizationStatusRestricted,        //未被授权访问照片数据.
    PHAuthorizationStatusDenied,            //用户明确拒绝此app访问照片数据
    PHAuthorizationStatusAuthorized         // 用户已授权该app访问照片数据
 */
- (PHAuthorizationStatus)authorizationStatus
{
    return [PHPhotoLibrary authorizationStatus];
}

- (void)registerChangeObserverAuthorizationStatus
{
    [[PHPhotoLibrary sharedPhotoLibrary] registerChangeObserver:self];
}

#pragma mark -- PHPhotoLibraryChangeObserver
///监听相册的图片发生变化的时候，会调用这个方法
- (void)photoLibraryDidChange:(PHChange *)changeInstance
{
    PHObjectChangeDetails *details = [changeInstance changeDetailsForObject:[PHObject new]];
    PHFetchResultChangeDetails *resultDetails = [changeInstance changeDetailsForFetchResult:[PHFetchResult new]];
}

- (void)getSmartAlbumWithAny
{
    PHFetchResult<PHAssetCollection *> *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAny options:nil];
    NSLog(@"fetchResult.count = %d", fetchResult.count);
    [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"assetCollectionType = %d, assetCollectionSubtype = %d, startDate = %@, endDate = %@, coordinate = %@, localizedLocationNames = %@", obj.assetCollectionType, obj.assetCollectionSubtype, obj.startDate, obj.endDate, [NSString stringWithFormat:@"latitude = %f, longitude = %f", obj.approximateLocation.coordinate.latitude, obj.approximateLocation.coordinate.latitude], obj.localizedLocationNames);
    }];
}

@end
