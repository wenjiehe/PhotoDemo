# PhotoDemo

## 简介

> 使用PhotoKit框架来获取iCloud Photos和Local photo library的图像资源

## SDKs

* iOS 8.0+
* macOS 10.11+
* Mac Catalyst 13.0+
* tvOS 10.0+

## 运行环境

* Xcode 11.3.1
* iOS 9.0及以上

## 工程配置

工程中必须在Info.plist文件中添加以下健值，否则会崩溃

```Objective-C
    <key>NSPhotoLibraryUsageDescription</key>
    <string>尊敬的用户，请允许APP访问您的相册</string>
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>尊敬的用户，请允许APP保持图片到相册</string>
```

## API介绍

```Objective-C
typedef NS_ENUM(NSInteger, PHAssetCollectionType) {
    PHAssetCollectionTypeAlbum      = 1, //从iTunes同步来的相册，以及用户在Photos中自己建立的相册
    PHAssetCollectionTypeSmartAlbum = 2, //经由相机得来的相册

    PHAssetCollectionTypeMoment     API_DEPRECATED("Will be removed in a future release", ios(8, 13), tvos(10, 13)) API_UNAVAILABLE(macos) = 3, //时刻，系统自动通过时间和地点生成的分组

};

typedef NS_ENUM(NSInteger, PHAssetCollectionSubtype) {
    
    // PHAssetCollectionTypeAlbum regular subtypes
    PHAssetCollectionSubtypeAlbumRegular         = 2, //用户在 Photos 中创建的相册
    PHAssetCollectionSubtypeAlbumSyncedEvent     = 3, //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件
    PHAssetCollectionSubtypeAlbumSyncedFaces     = 4, //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步的人物相册。
    PHAssetCollectionSubtypeAlbumSyncedAlbum     = 5, //使用 iTunes 从 Photos 照片库或者 iPhoto 照片库同步过来的事件
    PHAssetCollectionSubtypeAlbumImported        = 6, //从相机或是外部存储导入的相册
    
    // PHAssetCollectionTypeAlbum shared subtypes
    PHAssetCollectionSubtypeAlbumMyPhotoStream   = 100, //用户的 iCloud 照片流
    PHAssetCollectionSubtypeAlbumCloudShared     = 101, //用户使用 iCloud 共享的相册
    
    // PHAssetCollectionTypeSmartAlbum subtypes
    PHAssetCollectionSubtypeSmartAlbumGeneric    = 200, //文档解释为非特殊类型的相册，主要包括从 iPhoto 同步过来的相册。
    PHAssetCollectionSubtypeSmartAlbumPanoramas  = 201, //相机拍摄的全景照片
    PHAssetCollectionSubtypeSmartAlbumVideos     = 202, //相机拍摄的视频
    PHAssetCollectionSubtypeSmartAlbumFavorites  = 203, //标记为喜欢、收藏
    PHAssetCollectionSubtypeSmartAlbumTimelapses = 204, //延时拍摄、定时拍摄
    PHAssetCollectionSubtypeSmartAlbumAllHidden  = 205, //包含隐藏照片或视频的文件夹
    PHAssetCollectionSubtypeSmartAlbumRecentlyAdded = 206, //相机近期拍摄的照片或视频
    PHAssetCollectionSubtypeSmartAlbumBursts     = 207, //连拍模式拍摄的照片
    PHAssetCollectionSubtypeSmartAlbumSlomoVideos = 208, //高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。
    PHAssetCollectionSubtypeSmartAlbumUserLibrary = 209,  //相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里
    PHAssetCollectionSubtypeSmartAlbumSelfPortraits API_AVAILABLE(ios(9)) = 210, //使用前置摄像头拍摄的作品
    PHAssetCollectionSubtypeSmartAlbumScreenshots API_AVAILABLE(ios(9)) = 211, //屏幕截图
    PHAssetCollectionSubtypeSmartAlbumDepthEffect API_AVAILABLE(macos(10.13), ios(10.2), tvos(10.1)) = 212, //深度效果
    PHAssetCollectionSubtypeSmartAlbumLivePhotos API_AVAILABLE(macos(10.13), ios(10.3), tvos(10.2)) = 213, //实况照片
    PHAssetCollectionSubtypeSmartAlbumAnimated API_AVAILABLE(macos(10.15), ios(11), tvos(11)) = 214, //gif格式的集合
    PHAssetCollectionSubtypeSmartAlbumLongExposures API_AVAILABLE(macos(10.15), ios(11), tvos(11)) = 215, //长曝光照片集合
    PHAssetCollectionSubtypeSmartAlbumUnableToUpload API_AVAILABLE(macos(10.15), ios(13), tvos(13)) = 216,

    // Used for fetching, if you don't care about the exact subtype
    PHAssetCollectionSubtypeAny = NSIntegerMax  //包含所有类型
};
```

* Shared Photo Library

> 使用`PHPhotoLibrary`类,主要是用于获取整个照片应用程序管理的全部资源和集合，包括存储在本地设备上的资源和存储在iCloud Photos中的资源

* Asset Retrieval

* Asset Loading

> 获取图像、视频及实时图片内容，并缓存以便快速重用

`PHAsset`表示照片库中一个单独的资源，用来提供资源的元数据。

```Objective-C
 //以下是PHAsset类的一些属性
 playbackStyle:使用这个值选择在PHImageManager中显示资源的方式，而不管支持该资源的media type。
 mediaType:资源类型
 mediaSubtypes:图片资源又包含了全景图、HDR图片、屏幕截图、Live图片、3Dtouch效果图片、视频流、视频高帧率等
 pixelWidth:像素宽度
 pixelHeight:像素高度
 creationDate:创建时间
 modificationDate:修改时间
 location:位置信息
 duration:时长
 hidden:验证一个资源是否被用户标记为隐藏
 favorite:验证一个资源是否被用户标记为收藏
 representsBurst:验证一个资源是一系列连拍照片中的代表照片
 burstIdentifier:根据这个值，可以获取连拍照片中剩余的照片
 burstSelectionTypes:这个值表示这个元数据是否被标记:.None表示没有标记的资源  .UserPick表示用户手动标记的资源  .AutoPick表示用户可能标记的潜在资源
```

1. `PHImageManager`

> 对`Photos`的图片或视频资源提供了加载或生产预览图和全尺寸图片的方法

2. `PHCachingImageManager`

> 对`Photos`的图片或视频资源提供了加载或生产预览图和全尺寸图片的方法，针对预处理巨量的资源进行了优化

* Live Photos

> 使用`PHLivePhoto`类,主要是用于获取实时照片，`Live Photo`对象需要使用`PHLivePhotoView`类来展示

* Asset Resource Management

* Photo Editing Extensions

* macOS Photos Project Extensions

## 参考资料

[照片框架](https://objccn.io/issue-21-4/)

[apple官方文档](https://developer.apple.com/documentation/photokit?language=objc)

[PHImageManager](https://nshipster.com/phimagemanager/)
