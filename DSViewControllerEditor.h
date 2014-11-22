//
//  DSViewControllerEditor.h
//  PhotoGaleryEdit
//
//  Created by Dima on 11/19/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface DSViewControllerEditor : UIViewController <UITabBarDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UITabBar *tabBar;
@property (weak, nonatomic) IBOutlet UINavigationItem* navigationBarItem;
@property (strong, nonatomic) UIImage *image;

@property (strong, nonatomic) NSURL *fileURL;

@end
