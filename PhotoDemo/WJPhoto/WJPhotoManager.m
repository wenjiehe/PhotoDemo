//
//  WJPhotoManager.m
//  PhotoDemo
//
//  Created by 贺文杰 on 2020/5/7.
//  Copyright © 2020 贺文杰. All rights reserved.
//

#import "WJPhotoManager.h"

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

/// 获取所有的图片和视频数据
- (void)getSmartAlbum:(PHAssetCollectionType)type subType:(PHAssetCollectionSubtype)subType fetchResult:(void(^)(PHFetchResult<PHAsset *> *fetchResult))block
{
    PHFetchOptions *fetchOptions = [[PHFetchOptions alloc] init];
    fetchOptions.fetchLimit = 0; //限制获取结果中返回的对象最大数量，0 表示无限制
    fetchOptions.includeHiddenAssets = YES;//获取结果中是否包含隐藏资源,默认为NO
    fetchOptions.includeAllBurstAssets = YES;//获取结果中是否包含了隐藏的连拍资源，默认为NO
    /*
     typedef NS_OPTIONS(NSUInteger, PHAssetSourceType) {
         PHAssetSourceTypeNone            = 0,
         PHAssetSourceTypeUserLibrary     = (1UL << 0),
         PHAssetSourceTypeCloudShared     = (1UL << 1),
         PHAssetSourceTypeiTunesSynced    = (1UL << 2),
     } API_AVAILABLE(ios(9));
     */
    fetchOptions.includeAssetSourceTypes = PHAssetSourceTypeNone;//资源的来源,默认为PHAssetSourceTypeNone,如果设置为PHAssetSourceTypeNone，则获取结果中包含的资源类型是从执行的查询类型中推断出来的
    //筛选
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeImage];
    fetchOptions.predicate = [NSPredicate predicateWithFormat:@"mediaType = %d", PHAssetMediaTypeVideo];

    PHFetchResult<PHAssetCollection *> *fetchResult = [PHAssetCollection fetchAssetCollectionsWithType:type subtype:subType options:nil];
    NSLog(@"fetchResult.count = %d", fetchResult.count);
    [fetchResult enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSLog(@"assetCollectionType = %d, assetCollectionSubtype = %d, startDate = %@, endDate = %@, %@, localizedLocationNames = %@", obj.assetCollectionType, obj.assetCollectionSubtype, obj.startDate, obj.endDate, [NSString stringWithFormat:@"latitude = %f, longitude = %f", obj.approximateLocation.coordinate.latitude, obj.approximateLocation.coordinate.latitude], obj.localizedLocationNames);
        if (block) {
            block([PHAsset fetchAssetsInAssetCollection:obj options:nil]);
        }
        PHFetchResult<PHAsset *> *fetchResult = [PHAsset fetchAssetsInAssetCollection:obj options:nil];
        [fetchResult enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            /*
             typedef NS_ENUM(NSInteger, PHAssetPlaybackStyle) {
                 PHAssetPlaybackStyleUnsupported     = 0, //不支持或未定义的类型
                 PHAssetPlaybackStyleImage           = 1, //图片
                 PHAssetPlaybackStyleImageAnimated   = 2, //动画图像，包括gif等
                 PHAssetPlaybackStyleLivePhoto       = 3, //实况图片
                 PHAssetPlaybackStyleVideo           = 4, //视频
                 PHAssetPlaybackStyleVideoLooping    = 5, //循环视频
             } API_AVAILABLE(macos(10.13), ios(11), tvos(11)) NS_SWIFT_NAME(PHAsset.PlaybackStyle);
             */
            NSLog(@"PHAssetPlaybackStyle = %d, PHAssetMediaType = %d, PHAssetMediaSubtype = %d, pixelWidth = %d, pixelHeight = %d, creationDate = %@, modificationDate = %@, latitude = %f, longitude = %f, duration = %f, hidden = %d, favorite = %d, PHAssetSourceType = %d", obj.playbackStyle, obj.mediaType, obj.mediaSubtypes, obj.pixelWidth, obj.pixelHeight, obj.creationDate, obj.modificationDate, obj.location.coordinate.latitude, obj.location.coordinate.longitude, obj.duration, obj.hidden, obj.favorite, obj.sourceType);
            
            PHImageManager *imageManager = [PHImageManager defaultManager];
        }];
    }];
}

@end
