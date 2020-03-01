# PhotoDemo


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

    PHAssetCollectionTypeMoment     API_DEPRECATED("Will be removed in a future release", ios(8, 13), tvos(10, 13)) API_UNAVAILABLE(macos) = 3, //Photos为我们自动生成的时间分组的相册

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
    PHAssetCollectionSubtypeSmartAlbumFavorites  = 203, //收藏文件夹
    PHAssetCollectionSubtypeSmartAlbumTimelapses = 204, //延时视频文件夹，同时也会出现在视频文件夹中
    PHAssetCollectionSubtypeSmartAlbumAllHidden  = 205, //包含隐藏照片或视频的文件夹
    PHAssetCollectionSubtypeSmartAlbumRecentlyAdded = 206, //相机近期拍摄的照片或视频
    PHAssetCollectionSubtypeSmartAlbumBursts     = 207, //连拍模式拍摄的照片
    PHAssetCollectionSubtypeSmartAlbumSlomoVideos = 208, //高速摄影慢动作解析，在该模式下，iOS 设备以120帧拍摄。
    PHAssetCollectionSubtypeSmartAlbumUserLibrary = 209,  //相机相册，所有相机拍摄的照片或视频都会出现在该相册中，而且使用其他应用保存的照片也会出现在这里
    PHAssetCollectionSubtypeSmartAlbumSelfPortraits API_AVAILABLE(ios(9)) = 210,
    PHAssetCollectionSubtypeSmartAlbumScreenshots API_AVAILABLE(ios(9)) = 211,
    PHAssetCollectionSubtypeSmartAlbumDepthEffect API_AVAILABLE(macos(10.13), ios(10.2), tvos(10.1)) = 212,
    PHAssetCollectionSubtypeSmartAlbumLivePhotos API_AVAILABLE(macos(10.13), ios(10.3), tvos(10.2)) = 213,
    PHAssetCollectionSubtypeSmartAlbumAnimated API_AVAILABLE(macos(10.15), ios(11), tvos(11)) = 214,
    PHAssetCollectionSubtypeSmartAlbumLongExposures API_AVAILABLE(macos(10.15), ios(11), tvos(11)) = 215,
    PHAssetCollectionSubtypeSmartAlbumUnableToUpload API_AVAILABLE(macos(10.15), ios(13), tvos(13)) = 216,

    // Used for fetching, if you don't care about the exact subtype
    PHAssetCollectionSubtypeAny = NSIntegerMax  //包含所有类型
};
```

## 参考资料

[照片框架](https://objccn.io/issue-21-4/)
[apple官方文档](https://developer.apple.com/documentation/photokit?language=objc)
[PHImageManager](https://nshipster.com/phimagemanager/)
