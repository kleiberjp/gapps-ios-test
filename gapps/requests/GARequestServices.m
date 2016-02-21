//
//  GARequestServices.m
//  gapps
//
//  Created by Kleiber J Perez on 18/02/16.
//  Copyright © 2016 Kleiber J Perez. All rights reserved.
//

#import "GARequestServices.h"
#import "AFNetworking.h"
#import "Applications.h"
#import "AppItemCell.h"
#import "ColorPallete.h"
#import "NSString+StringExtension.h"
#import "UIImageView+WebCache.h"
#import "UIImageView+RJLoader.h"
#import "UIImage+ImageExtension.h"
#import "UIViewController+ViewControllerExtension.h"

@implementation GARequestServices

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.userDefaults = [[UserDefault alloc] init];
    }
    return self;
}

- (instancetype) initWithSuperView:(UIViewController *) view{
    self = [super init];
    if (self) {
        self.superView = view;
        self.userDefaults = [[UserDefault alloc] init];
    }
    return self;
}


-(void)downLoadApplications:(void (^)(NSProgress *))progress success:(void (^)(BOOL))success{
    __block Applications *listApps;
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_group_enter(group);

    NSString *URLString = @"https://itunes.apple.com/us/rss/topfreeapplications/limit=20/json";
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager GET:URLString
      parameters:nil
        progress:^(NSProgress * _Nonnull downloadProgress) {
            if (progress) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    progress(downloadProgress);
                });
            }
        }
         success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             NSDictionary *data = (NSDictionary *)responseObject;
             data = data[@"feed"];
             listApps = [[Applications alloc] initWithDictionary:data];
             [self.userDefaults saveApplications:listApps];
             if (success && listApps != nil && listApps.entry.count != 0) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     success(YES);
                 });
             }
             dispatch_group_leave(group);
         }
         failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 [self.superView showAlert:@"Error"
                               withMessage:[NSString getMessageText:@"ERROR"]];
             });
             dispatch_group_leave(group);
         }
     ];
    dispatch_group_wait(group, DISPATCH_TIME_FOREVER);
}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    
    if ([keyPath isEqualToString:@"fractionCompleted"] && [object isKindOfClass:[NSProgress class]]) {
        NSProgress *progress = (NSProgress *)object;
        NSLog(@"Progress is %f", progress.fractionCompleted);
    }
}

-(void)downloadImage:(NSString *)ulr andSetAtCell:(AppItemCell *)cellApp success:(void (^)(UIImage *image))successFully{
    NSURL *url = [NSURL URLWithString:ulr];
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_async(queue, ^(void) {
        UIImage *notImg = [[UIImage imageNamed:@"ImgNotAvaliable"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
        notImg = [notImg imageTintedWithColor:green_primary];
        [cellApp.appIconPreview startLoaderWithTintColor:green_primary];
        [cellApp.appIconPreview sd_setImageWithURL:url
                     placeholderImage:notImg
                              options:SDWebImageCacheMemoryOnly | SDWebImageRefreshCached
                             progress:^(NSInteger receivedSize, NSInteger expectedSize) {
                                 [cellApp.appIconPreview updateImageDownloadProgress:(CGFloat)receivedSize/expectedSize];
                             }
                            completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                if (image) {
                                    cellApp.appIconPreview.image = image;
                                    [cellApp.appIconPreview reveal];
                                    [cellApp setNeedsLayout];
                                    if (successFully) {
                                        dispatch_async(dispatch_get_main_queue(), ^{
                                            successFully(image);
                                        });
                                    }
                                }
                            }
         ];
    });
}



@end
