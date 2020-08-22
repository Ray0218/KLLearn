//
//  NSObject+json.h
//  KLTimer
//
//  Created by WKL on 2020/8/20.
//  Copyright © 2020 Ray. All rights reserved.
//

 

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSObject (json)

+(instancetype)mj_objctWithJson:(NSDictionary*)json;

@end

NS_ASSUME_NONNULL_END
