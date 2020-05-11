//
//  WJMainView.m
//  PhotoDemo
//
//  Created by 贺文杰 on 2020/3/1.
//  Copyright © 2020 贺文杰. All rights reserved.
//

#import "WJMainView.h"
#import <Photos/Photos.h>
#import <PhotosUI/PhotosUI.h>

@interface WJMainView ()

@end

@implementation WJMainView

- (instancetype)init
{
    self = [super init];
    if (self) { 
        [self initViewAndInitData];
    }
    return self;
}

- (void)initViewAndInitData
{
    PHFetchResult<PHAssetCollection *> *ary = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSLog(@"ary.count = %ld", ary.count);
    [ary enumerateObjectsUsingBlock:^(PHAssetCollection * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection *ac = obj;
        NSLog(@"assetCollectionType = %d, assetCollectionSubtype = %d, startDate = %@, endDate = %@, %@, localizedLocationNames = %@", obj.assetCollectionType, obj.assetCollectionSubtype, obj.startDate, obj.endDate, [NSString stringWithFormat:@"latitude = %f, longitude = %f", obj.approximateLocation.coordinate.latitude, obj.approximateLocation.coordinate.latitude], obj.localizedLocationNames);
        for (NSString *str in ac.localizedLocationNames) {
            NSLog(@"localizedLocationNames = %@", str);
        }
        PHFetchResult<PHAsset *> *fr = [PHAsset fetchAssetsInAssetCollection:ac options:[[PHFetchOptions alloc] init]];
        NSLog(@"PHAsset.count = %d", fr.count);
        for (PHAsset *ass in fr) {
            [[PHImageManager defaultManager] requestImageForAsset:ass targetSize:CGSizeMake(500, 500) contentMode:PHImageContentModeDefault options:[self requestImage] resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                NSLog(@"result = %@, info = %@", result, info);
            }];
        }
    }];
    
}

- (PHImageRequestOptions *)requestImage
{
    PHImageRequestOptions *reque = [[PHImageRequestOptions alloc] init];
    reque.synchronous = YES;
    reque.resizeMode = PHImageRequestOptionsResizeModeFast;
    reque.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    
    return reque;
}


- (void)requestImageAll
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
