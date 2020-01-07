//
//  UIView+PopAlert.h
//  AirspaceProject
//
//  Created by xujiahui on 2018/8/11.
//  Copyright © 2018年 AirspaceProject. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^actionFunc)(void);

@interface UIViewPopAlert :NSObject

///选择列表 targer:VC\actions数组\type:1取消2删除3正常
+(void)pushAlertSheetTarget:(UIViewController*)target title:(NSString*)title actions:(NSArray*)actions lastActionType:(int)type ActionTag:(void(^)(int tag))ActionsTag;

///返回 富文本  string  font  lins间距
+(NSMutableAttributedString*)GetAttributeStringswithString:(NSString*)string  HaveFont:(CGFloat)font Lins:(CGFloat)lins Alifnment:(NSTextAlignment)alignment;


/**提示显示  左对齐
 yes:又间距 设置字体大小
NO： 系统默认
 @param message <#message description#>
 @param target <#target description#>
 @param title <#title description#>
 @param alertTitle <#alertTitle description#>
 1*/
+(void)pushAlertViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title AlertTitle:(NSString *)alertTitle ChangeSystem:(BOOL)boools;


/**
 两个 button
 yes:又间距 设置字体大小
 NO： 系统默认
 @param message <#message description#>
 @param target <#target description#>
 @param title <#title description#>
 @param oneAlertTitle <#oneAlertTitle description#>
 @param twoAlertTitle <#twoAlertTitle description#>
 @param oneActionfunc <#oneActionfunc description#>
 @param twoActionfunc <#twoActionfunc description#>
 */
+(void)pushAlertTwoActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle twoAlertTitle:(NSString *)twoAlertTitle ChangeSystem:(BOOL)boools oneActionfunc:(actionFunc )oneActionfunc twoActionfunc:(actionFunc)twoActionfunc ;


/**
 一个button
 yes:有间距 设置字体大小
 NO： 系统默认
 @param message <#message description#>
 @param target <#target description#>
 @param title <#title description#>
 @param oneAlertTitle <#oneAlertTitle description#>
 @param oneActionfunc <#oneActionfunc description#>
 */
+(void)pushAlertOneActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title oneAlertTitle:(NSString *)oneAlertTitle ChangeSystem:(BOOL)boools  oneActionfunc:(actionFunc )oneActionfunc ;
///添加一个textfiel
+(void)pushAlertOneTextFieldActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title placeholder:(NSString*)oneplaceholder  RightActionfunc:(void(^)(NSString * oneText) )RightActionfunc error:(actionFunc)errorAction;

///添加两个textfiel
+(void)pushAlertTwoTextFieldActionViewWithMessage:(NSString *)message Target:(UIViewController *)target Title:(NSString *)title OnePlaceholder:(NSString*)oneplaceholder twoPlaceholder:(NSString*)twoplaceholder  TwosecureTextEntry:(BOOL)secureTextEntry RightActionfunc:(void(^)(NSString * oneText,NSString * twoText))RightActionfunc  error:(actionFunc)errorAction;
@end
