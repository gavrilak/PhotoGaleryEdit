//
//  DSViewControllerMain.m
//  PhotoGaleryEdit
//
//  Created by Dima on 11/19/14.
//  Copyright (c) 2014 Dima Soldatenko. All rights reserved.
//

#import "DSViewControllerMain.h"
#import "DSViewControllerEditor.h"


@interface DSViewControllerMain ()

   @property(weak, nonatomic) DSViewControllerEditor* nextController;

@end

@implementation DSViewControllerMain

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)galleryButtonPressed:(id)sender {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        pickerController.allowsEditing = YES;      
        pickerController.delegate = self;
        [self presentViewController:pickerController animated:YES completion:NULL];
    }
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:NULL];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    NSURL* fileURL = [info objectForKey: UIImagePickerControllerReferenceURL];
    self.nextController.image=image;
    self.nextController.fileURL = fileURL;
   
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    self.nextController = [segue destinationViewController];
    
}


@end
