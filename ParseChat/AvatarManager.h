//
//  AvatarManager.h
//  ParseChat
//
//  Created by Fiona Barry on 7/6/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface AvatarManager : NSObject

+ (NSURL *)getAvatarWithIdentifier:(NSString *)identifier withCompletion:(void(^)(NSURL *avatar, NSError *error))completion;

@end

NS_ASSUME_NONNULL_END
