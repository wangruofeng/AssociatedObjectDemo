//
//  ViewController.m
//  AssociatedObjectDemo
//
//  Created by 王若风 on 4/14/16.
//  Copyright © 2016 王若风. All rights reserved.
//

#import "ViewController.h"
#import "UIImagePickerController+RFBlocks.h"
#import "UIButton+RFBlcoks.h"
#import "UIViewController+RFPresentPopover.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.button.rf_buttonClickBlock = ^(UIButton *button){
        NSLog(@"%@ clicked",button);
    };
}

- (IBAction)showImagePickerController:(id)sender {
    
    //    [self test1];
    [self test2];
}


- (IBAction)showPoperViewController:(id)sender {
    
    UIViewController *vc = [UIViewController new];
    vc.view.backgroundColor = [UIColor orangeColor];
    
    [self rf_presentPopoverWithViewController:vc fromRect:self.button.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionRight animated:YES];
}

- (void)test1
{
    __weak typeof(self)weakSelf = self;
    
    UIImagePickerController *picker =  [UIImagePickerController rf_imagePickerWithFinishBlock:^(NSDictionary *info) {
        NSLog(@"finish picke image\n info:%@",info);
        
        UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
        weakSelf.view.layer.contents = (id)img.CGImage;
    }];
    
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)test2
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    
    __weak typeof(self)weakSelf = self;
    
    picker.rf_finishBlock = ^(NSDictionary *info) {
        NSLog(@"finish picke image\n info:%@",info);
        
        UIImage *img = info[@"UIImagePickerControllerOriginalImage"];
        weakSelf.view.layer.contentsGravity = kCAGravityResizeAspect;
        weakSelf.view.layer.contents = (id)img.CGImage;
    };
    
    [self presentViewController:picker animated:YES completion:nil];
}

@end
