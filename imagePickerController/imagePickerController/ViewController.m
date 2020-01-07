//
//  ViewController.m
//  imagePickerController
//
//  Created by mac on 2020/1/7.
//  Copyright © 2020 mac. All rights reserved.
//

#import "ViewController.h"
//#import <Photos/Photos.h>
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIViewPopAlert.h"
@interface ViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
@property(nonatomic,strong) UIImagePickerController * pickerController ;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, self.view.frame.size.width, 50)];
    label.text = @"点击屏幕选择";
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [self.view addSubview:label];
    
    
}

- (UIImagePickerController *)pickerController{
    
    if (_pickerController == nil) {
        _pickerController = [[UIImagePickerController alloc] init];
        _pickerController.delegate = self;
        _pickerController.allowsEditing = NO;
    }
    return _pickerController;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{
    
    //判断资源是照片还是视频
    NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    
    if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
        //获取原照片Privacy - Photo Library Additions Usage Description
        UIImage * image = [info objectForKey:UIImagePickerControllerOriginalImage];
       
       UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);
        
        [self.pickerController dismissViewControllerAnimated:YES completion:nil];
        
    }else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){
        
        //视频处理
        [self.pickerController dismissViewControllerAnimated:YES completion:^{
            
            //视频的URL
            NSURL *movieURL = info[UIImagePickerControllerMediaURL];
            
//            //文件管理器
//            NSFileManager* fm = [NSFileManager defaultManager];
//
//            //创建视频的存放路径
//            NSString * path = [NSString stringWithFormat:@"%@/tmp/video%.0f.merge.mp4", NSHomeDirectory(), [NSDate timeIntervalSinceReferenceDate] * 1000];
//            NSURL *mergeFileURL = [NSURL fileURLWithPath:path];
//
//            //通过文件管理器将视频存放的创建的路径中
//            [fm copyItemAtURL:[info objectForKey:UIImagePickerControllerMediaURL] toURL:mergeFileURL error:nil];
//            AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
//
//            //根据AVURLAsset得出视频的时长
//            CMTime   time = [asset duration];
//            int seconds = ceil(time.value/time.timescale);
            
            
            //可以根据需求判断是否需要将录制的视频保存到系统相册中
            // 判断获取类型：视频
            
            //获取视频文件的url
            NSURL* mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
            //创建ALAssetsLibrary对象并将视频保存到媒体库
            // Assets Library 框架包是提供了在应用程序中操作图片和视频的相关功能。相当于一个桥梁，链接了应用程序和多媒体文件。
            ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
            // 将视频保存到相册中
            [assetsLibrary writeVideoAtPathToSavedPhotosAlbum:movieURL
             
                                              completionBlock:^(NSURL *assetURL, NSError *error) {
                NSString * alertString = @"";
                if (!error) {
                    alertString = @"视频已保存到相册";
                }else{
                    alertString = @"视频保存到相册失败";
                    
                }
                
                [UIViewPopAlert pushAlertOneActionViewWithMessage:alertString Target:self Title:@"提示" oneAlertTitle:@"确定" ChangeSystem:NO oneActionfunc:^{
                    
                }];
                
            }];
        }];
    }
    
    
    
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"选取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction * cameraAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }];
    
    UIAlertAction * videoAction = [UIAlertAction actionWithTitle:@"拍视频" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.pickerController.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        ///拍摄模式 此时不可以设置
        //        self.pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
        
        self.pickerController.mediaTypes = @[(NSString*)kUTTypeMovie];
        //视频编码质量
        self.pickerController.videoQuality = UIImagePickerControllerQualityTypeMedium;
        //视频录制时间。默认600s
        self.pickerController.videoMaximumDuration = 15;
        
        //模态视图的弹出效果
        self.pickerController.modalPresentationStyle=UIModalPresentationOverFullScreen;
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }];
    
    UIAlertAction * photosLibaryAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        //设置媒体类型：照片public.image或视频public.movie
        //        self.pickerController.mediaTypes = @[@"public.movie",@"public.image"];
        self.pickerController.mediaTypes = @[(NSString*)kUTTypeMovie,(NSString*)kUTTypeImage];
        [self presentViewController:self.pickerController animated:YES completion:nil];
    }];
    
    UIAlertAction * cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    //判断是否支持相机
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        [alert addAction:cameraAction];
        [alert addAction:videoAction];
    }
    
    [alert addAction:photosLibaryAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
}


-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo

{
    
    NSString *msg = nil ;
    
    if(error != NULL){
        
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    
    NSLog(@"%@",msg);
    [UIViewPopAlert pushAlertOneActionViewWithMessage:msg Target:self Title:@"提示" oneAlertTitle:@"确定" ChangeSystem:NO oneActionfunc:^{
        
    }];
    
}

@end
