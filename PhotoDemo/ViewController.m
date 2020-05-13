//
//  ViewController.m
//  PhotoDemo
//
//  Created by 贺文杰 on 2020/3/1.
//  Copyright © 2020 贺文杰. All rights reserved.
//

#import "ViewController.h"
#import "WJMainView.h"
#import "WJPhotoManager.h"

@interface ViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    WJMainView *mainV = [[WJMainView alloc] init];
    mainV.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [self.view addSubview:mainV];
    
    [[WJPhotoManager shareInstance] getSmartAlbum:PHAssetCollectionTypeSmartAlbum subType:PHAssetCollectionSubtypeAny fetchResult:^(PHFetchResult<PHAsset *> * _Nonnull fetchResult) {
        [fetchResult enumerateObjectsWithOptions:NSEnumerationConcurrent usingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSLog(@"PHAssetPlaybackStyle = %d, PHAssetMediaType = %d, PHAssetMediaSubtype = %d, pixelWidth = %d, pixelHeight = %d, creationDate = %@, modificationDate = %@, latitude = %f, longitude = %f, duration = %f, hidden = %d, favorite = %d, PHAssetSourceType = %d", obj.playbackStyle, obj.mediaType, obj.mediaSubtypes, obj.pixelWidth, obj.pixelHeight, obj.creationDate, obj.modificationDate, obj.location.coordinate.latitude, obj.location.coordinate.longitude, obj.duration, obj.hidden, obj.favorite, obj.sourceType);
        }];
    }];
}


//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
//{
//    return 0;
//}
//
//// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return nil;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
//{
//
//}

@end
