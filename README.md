# UIImagePickerControllerManager
拍摄照片、视频；相册权限、照片视频获取、保存本地

1、相册的权限 info.plist

<key>NSPhotoLibraryAddUsageDescription</key>

<string>需要打开存储到相册权限，保存照片/视频到相册</string>

<key>NSMicrophoneUsageDescription</key>

<string>录制需要打开麦克风，视频时使用</string>

<key>NSAppleMusicUsageDescription</key>

<string>需要获取本地视频权限，进行选择视频。。</string>

<key>NSPhotoLibraryUsageDescription</key>

<string>需要打开相册权限，访问相册选择照片</string>

<key>NSCameraUsageDescription</key>

<string>需要打开相机权限，进行拍照/录像</string>

 

2、需要使用的系统库、代理、初始化UIImagePickerController

#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>

//代理

<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//初始化picker

。。。。

3、功能支持判断

//判断是否支持相机

if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
}

4、触发资源选择 相机、 相册

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
// self.pickerController.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
//视频类型
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
// self.pickerController.mediaTypes = @[@"public.movie",@"public.image"];

//或者这样设置
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

 

 

5、判断获取资源类型\ 保存 本地

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info{

//判断资源是照片还是视频
NSString * mediaType = [info objectForKey:UIImagePickerControllerMediaType];

if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {

//照片

UIImageWriteToSavedPhotosAlbum(image,self,@selector(image:didFinishSavingWithError:contextInfo:),NULL);

[self.pickerController dismissViewControllerAnimated:YES completion:nil];

 

}else if([mediaType isEqualToString:(NSString *)kUTTypeMovie]){

//视频

//视频处理
[self.pickerController dismissViewControllerAnimated:YES completion:^{

//视频的URL
NSURL *movieURL = info[UIImagePickerControllerMediaURL];

// //文件管理器
// NSFileManager* fm = [NSFileManager defaultManager];
//
// //创建视频的存放路径
// NSString * path = [NSString stringWithFormat:@"%@/tmp/video%.0f.merge.mp4", NSHomeDirectory(), [NSDate timeIntervalSinceReferenceDate] * 1000];
// NSURL *mergeFileURL = [NSURL fileURLWithPath:path];
//
// //通过文件管理器将视频存放的创建的路径中
// [fm copyItemAtURL:[info objectForKey:UIImagePickerControllerMediaURL] toURL:mergeFileURL error:nil];
// AVURLAsset * asset = [AVURLAsset assetWithURL:[NSURL fileURLWithPath:path]];
//
// //根据AVURLAsset得出视频的时长
// CMTime time = [asset duration];
// int seconds = ceil(time.value/time.timescale);


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

}];

}];

 

}

}

///保存照片 结果

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

 
