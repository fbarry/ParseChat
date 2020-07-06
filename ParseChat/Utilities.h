//
//  Utilities.h
//  ParseChat
//
//  Created by Fiona Barry on 7/6/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Utilities : NSObject

+ (void) presentOkAlertControllerInViewController:(UIViewController *)viewController
                                        withTitle:(NSString *)title
                                          message:(NSString *)message;

@end

NS_ASSUME_NONNULL_END
