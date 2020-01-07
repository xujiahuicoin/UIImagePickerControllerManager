//
//  UIView+PopAlert.m
//  AirspaceProject
//
//  Created by xujiahui on 2018/8/11.
//  Copyright © 2018年 AirspaceProject. All rights reserved.
//


/*

 [alertController setValue:attrStr forKey:@"attributedTitle"];//修改title的，就是第一行标题
 
 
 [alertController setValue:attrStr forKey:@"attributedMessage"];//修改message，就是下一行小字的
*/

#import "UIViewPopAlert.h"

#define titleLins 20
#define titleFont 34

#define messageLins 5
#define messageFont 28
#define alertV1VC0 0
@implementation UIViewPopAlert




///选择列表 targer:VC\actions数组\type:1取消2删除3正常
+(void)pushAlertSheetTarget:(UIViewController*)target title:(NSString*)title actions:(NSArray*)actions lastActionType:(int)type ActionTag:(void(^)(int tag))ActionsTag{
    
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@""
                                                                   message:title
                                                            preferredStyle:UIAlertControllerStyleActionSheet];
    
    for (int i=0;i<actions.count;i++) {
        
        UIAlertActionStyle  styles = UIAlertActionStyleDefault;
        
        if (i==actions.count-1) {
            ///最后一个设置
            if (type==1) {
                styles = UIAlertActionStyleCancel;
            }else if (type==2){
                
                styles = UIAlertActionStyleDestructive;
            }
            
        }
        
        UIAlertAction* Action = [UIAlertAction actionWithTitle:actions[i]
                                                         style:styles
                                                       handler:^(UIAlertAction * action) {
                                                           
                                                           ActionsTag(i);
                                                       }];
        
        [alert addAction:Action];
        
    }
    
    [target presentViewController:alert animated:YES completion:nil];
}


+(NSMutableAttributedString*)GetAttributeStringswithString:(NSString*)string  HaveFont:(CGFloat)font Lins:(CGFloat)lins  Alifnment:(NSTextAlignment)alignment{
    
    ////title--------------------------------------------------------------------
    NSMutableAttributedString * attributedStringtitle = [[NSMutableAttributedString alloc] initWithString:string];
    //设置行高 字体大小
    NSMutableParagraphStyle *paragraphStyletitle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyletitle setLineSpacing:lins];
    paragraphStyletitle.alignment = alignment;
    ///字体大小
    [attributedStringtitle addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:font] range:NSMakeRange(0, string.length)];
    ///行间距
    [attributedStringtitle addAttribute:NSParagraphStyleAttributeName value:paragraphStyletitle range:NSMakeRange(0, [string length])];
    
    
    return attributedStringtitle;
    
    
}
+(void)pushAlertViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title AlertTitle:(NSString *)alertTitle ChangeSystem:(BOOL)boools TextAlignment:(NSTextAlignment)TextAlignment{
    
    
   
        
        
        
        UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertView addAction:[UIAlertAction actionWithTitle:alertTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        
        if(boools){
            
            [alertView setValue:[UIViewPopAlert GetAttributeStringswithString:title HaveFont:titleFont Lins:titleLins Alifnment:NSTextAlignmentCenter] forKey:@"attributedTitle"];//修改title
            
            ///message-----------------------------------------------------------------
            
            [alertView setValue:[UIViewPopAlert GetAttributeStringswithString:message HaveFont:messageFont Lins:messageLins Alifnment:TextAlignment] forKey:@"attributedMessage"];//修改message，就是下一行小字的
            
        }
        
        
        [target presentViewController:alertView animated:YES completion:nil];
        
    
}




+(void)pushAlertTwoActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle twoAlertTitle:(NSString *)twoAlertTitle ChangeSystem:(BOOL)boools oneActionfunc:(actionFunc )oneActionfunc twoActionfunc:(actionFunc)twoActionfunc{
 
    
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *oneaction = [UIAlertAction actionWithTitle:oneAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        oneActionfunc();
        
    }];

    [alertView addAction:oneaction];
    
    UIAlertAction *twoaction = [UIAlertAction actionWithTitle:twoAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        twoActionfunc();
        
    }];

    [alertView addAction:twoaction];

    
    if(boools){
        
    [alertView setValue:[UIViewPopAlert GetAttributeStringswithString:title HaveFont:titleFont Lins:titleLins Alifnment:NSTextAlignmentCenter] forKey:@"attributedTitle"];//修改title
        
    ///message-----------------------------------------------------------------
    [alertView setValue:[UIViewPopAlert GetAttributeStringswithString:message HaveFont:messageFont Lins:messageLins Alifnment:NSTextAlignmentLeft] forKey:@"attributedMessage"];//修改message，就是下一行小字的
    
    }
    
    [target presentViewController:alertView animated:YES completion:nil];
    
        
    
    
}

+(void)pushAlertOneActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle  ChangeSystem:(BOOL)boools  oneActionfunc:(actionFunc)oneActionfunc{
    
    
    
    UIAlertController *alertView = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *oneaction = [UIAlertAction actionWithTitle:oneAlertTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        oneActionfunc();
        
    }];

    [alertView addAction:oneaction];
    
    if(boools){
    
    [alertView setValue:[UIViewPopAlert GetAttributeStringswithString:title HaveFont:titleFont Lins:titleLins Alifnment:NSTextAlignmentCenter] forKey:@"attributedTitle"];//修改title
        
    ///message-----------------------------------------------------------------
    [alertView setValue:[UIViewPopAlert GetAttributeStringswithString:message HaveFont:messageFont Lins:messageLins Alifnment:NSTextAlignmentLeft] forKey:@"attributedMessage"];//修改message，就是下一行小字的
    
    }
    
        //[UIApplication sharedApplication].keyWindow.rootViewController
    [target presentViewController:alertView animated:YES completion:nil];
    
        
    
}

+(void)pushAlertOneTextFieldActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title placeholder:(NSString *)oneplaceholder RightActionfunc:(void (^)(NSString *))RightActionfunc error:(actionFunc)errorAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = oneplaceholder;
        textField.placeholder = oneplaceholder;
        textField.clearButtonMode=  UITextFieldViewModeAlways;
        //        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.borderStyle = UITextBorderStyleNone;
    }];
    
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *phone = alertController.textFields.firstObject;
        if (phone.text.length>0) {
            
            RightActionfunc(phone.text);
            
        }else{
            errorAction();
        }
        
        
    }];
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    [target presentViewController:alertController animated:YES completion:nil];
    
}

+(void)pushAlertTwoTextFieldActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title OnePlaceholder:(NSString *)oneplaceholder twoPlaceholder:(NSString *)twoplaceholder TwosecureTextEntry:(BOOL)secureTextEntry  RightActionfunc:(void (^)(NSString *, NSString *))RightActionfunc error:(actionFunc)errorAction{
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = oneplaceholder;
        textField.clearButtonMode=  UITextFieldViewModeAlways;
        textField.keyboardType = UIKeyboardTypeNumberPad;
        textField.borderStyle = UITextBorderStyleNone;
    }];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = twoplaceholder;
        textField.secureTextEntry = secureTextEntry;
        textField.clearButtonMode=  UITextFieldViewModeAlways;
        textField.keyboardType = UIKeyboardTypeDefault;
        textField.borderStyle = UITextBorderStyleNone;
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        
        UITextField *phone = alertController.textFields.firstObject;
        UITextField * phone2 = alertController.textFields.lastObject;
        
        if (phone.text.length>0 && phone2.text.length>0) {
            
            RightActionfunc(phone.text,phone2.text);
            
        }else{
            
            errorAction();
            
        }
        
        
    }];
    
    
    [alertController addAction:cancelAction];
    [alertController addAction:okAction];
    
    
    [target presentViewController:alertController animated:YES completion:nil];
    
}
@end
