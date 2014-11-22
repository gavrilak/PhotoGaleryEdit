//
//  DSViewControllerEditor.m
//  PhotoGaleryEdit
//
//  Created by Dima on 11/19/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import "DSViewControllerEditor.h"


@interface DSViewControllerEditor (){
    UIImage *newImage;
}
@end

@implementation DSViewControllerEditor

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.imageView setImage:self.image];
    [[[self.tabBar items] objectAtIndex:4] setEnabled:FALSE];
    UIBarButtonItem* done =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                  target:self
                                                  action:@selector(endEdit)];
    
    self.navigationBarItem.rightBarButtonItem = done;
    [self.navigationBarItem.rightBarButtonItem  setEnabled:FALSE];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) endEdit{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (UIImage*) scaledImage: (UIImage*) image toSize: (CGSize) size {
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
  

}

-(void)saveImageToPhotoLibrary:(UIImage*)image replace:(BOOL) bReplace
{
    
    NSData *data = UIImageJPEGRepresentation(image,1.0f);
            
    ALAssetsLibrary *assetLibrary=[[ALAssetsLibrary alloc] init];
    [assetLibrary assetForURL:self.fileURL resultBlock:^(ALAsset *asset) {
           
            if(bReplace){
                if([asset isEditable]){
                    [asset setImageData:data metadata:[[asset defaultRepresentation] metadata] completionBlock:^(NSURL *assetURL, NSError *error) {
                   if (assetURL == nil)
                       NSLog(@"Error: %@",[error localizedDescription]);
                    }];
                    }
            }
            else {
            [asset writeModifiedImageDataToSavedPhotosAlbum:data metadata:[[asset defaultRepresentation] metadata] completionBlock:^(NSURL *assetURL, NSError *error) {
                    if (assetURL == nil)
                        NSLog(@"Error: %@",[error localizedDescription]);
                        }];
            }
    }
    failureBlock:^(NSError *err) {
    NSLog(@"Error: %@",[err localizedDescription]);
    }];
            
    
}




#pragma mark -  UITabBarDelegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    
   
    UIImage* sendImage;
    switch (item.tag)
    {
        case 1:
            newImage =[self scaledImage:self.image toSize:CGSizeMake(1632, 1224)];
            break;
        case 2:
            newImage =[self scaledImage:self.image toSize:CGSizeMake(1280, 960)];
            break;
        case 3:
            
            newImage =[self scaledImage:self.image toSize:CGSizeMake(640, 480)];
            break;
        case 4:
            
           sendImage = newImage;
            UIActivityViewController *activityViewController = [[UIActivityViewController alloc]
                                                                initWithActivityItems:@[ sendImage] applicationActivities:nil];
            activityViewController.excludedActivityTypes=@[UIActivityTypeCopyToPasteboard,UIActivityTypeAssignToContact,UIActivityTypePostToWeibo,UIActivityTypePrint,UIActivityTypeSaveToCameraRoll];
          
            [self presentViewController:activityViewController animated:YES completion:nil];
            break;
           
    }
    if (sendImage == NULL){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Do you want to replace original image?" message:nil delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes",nil];
        [alert show];
        
    }
}

#pragma mark -  UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [self saveImageToPhotoLibrary:newImage  replace:NO];
   }
    else if (buttonIndex == 1) {
        [self saveImageToPhotoLibrary:newImage  replace:YES];
    }
   [[[self.tabBar items] objectAtIndex:4] setEnabled:YES];
   [self.navigationBarItem.rightBarButtonItem  setEnabled:YES];
}


@end
