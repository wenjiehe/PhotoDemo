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
    PHFetchResult *ary = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    NSLog(@"ary.count = %ld", ary.count);
    [ary enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        PHAssetCollection *ac = obj;
        NSLog(@"startDate = %@, endDate = %@, latitude = %.f, longitude = %.f", ac.startDate, ac.endDate, ac.approximateLocation.coordinate.latitude, ac.approximateLocation.coordinate.longitude);
    }];
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
