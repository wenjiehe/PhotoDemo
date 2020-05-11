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

```
    <key>NSPhotoLibraryUsageDescription</key>
    <string>尊敬的用户，请允许APP访问您的相册</string>
    <key>NSPhotoLibraryAddUsageDescription</key>
    <string>尊敬的用户，请允许APP保持图片到相册</string>
```

## API介绍

```
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
