//
//  AvatarManager.m
//  ParseChat
//
//  Created by Fiona Barry on 7/6/20.
//  Copyright © 2020 fbarry. All rights reserved.
//

#import "AvatarManager.h"

@implementation AvatarManager

+ (NSURL *)getAvatarWithIdentifier:(NSString *)identifier withCompletion:(void(^)(NSURL *avatar, NSError *error))completion {
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.adorable.io/avatars/285/%@.png", identifier]];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"%@", [error localizedDescription]);
            completion(nil, error);
        }
        else {
            completion(, nil);
        }
    }];
    [task resume];
}

@end
