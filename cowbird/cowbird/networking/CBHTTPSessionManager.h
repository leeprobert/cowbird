//
//  CDHTTPSessionManager.h
//  CollinsDictionary
//
//  Created by Lee Probert on 20/03/2014.
//  Copyright (c) 2014 leeprobert. All rights reserved.
//

#import "AFHTTPSessionManager.h"

@protocol CDHTTPSessionDelegate;

@interface CBHTTPSessionManager : AFHTTPSessionManager

@property (nonatomic, weak) id<CDHTTPSessionDelegate>delegate;
@property (nonatomic, copy) NSString* accessKey;

+(CBHTTPSessionManager*)sharedSessionManager;
- (instancetype)initWithBaseURL:(NSURL *)url;

-(void)getDictionaries;
-(void)makeASearch:(NSString*)query;
-(void)getAnEntry:(NSString*)entryId;

@end

@protocol CDHTTPSessionDelegate <NSObject>

@optional

-(void)CDHTTPSession:(CBHTTPSessionManager*)session didReturnDictionariesList:(id)object;
-(void)CDHTTPSession:(CBHTTPSessionManager*)session didReturnDictionary:(id)object;
-(void)CDHTTPSession:(CBHTTPSessionManager*)session didReturnSearchResultList:(id)object;
-(void)CDHTTPSession:(CBHTTPSessionManager*)session didReturnEntry:(id)object;

@end
