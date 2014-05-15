//
//  CDHTTPSessionManager.m
//  CollinsDictionary
//
//  Created by Lee Probert on 20/03/2014.
//  Copyright (c) 2014 leeprobert. All rights reserved.
//

#import "CBHTTPSessionManager.h"

static NSString *const API_URL_BASE                = @"https://api.collinsdictionary.com/";
static NSString *const API_URL_API                 = @"api/v1/";
static NSString *const API_URL_DICTIONARIES        = @"dictionaries";
static NSString *const API_URL_DEFAULT_DICTIONARY  = @"english";
static NSString *const API_URL_SEARCH              = @"search";
static NSString *const API_URL_ENTRIES             = @"entries";

@implementation CBHTTPSessionManager

+(CBHTTPSessionManager*)sharedSessionManager{
    
    static CBHTTPSessionManager *_sharedSessionManager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedSessionManager = [[self alloc] initWithBaseURL:[NSURL URLWithString:[API_URL_BASE stringByAppendingString:API_URL_API]]];
    });
    
    return _sharedSessionManager;
}

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    
    if (self) {
        
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer = [AFJSONRequestSerializer serializer];
    }
    
    return self;
}

#pragma mark - setters

-(void) setAccessKey:(NSString *)accessKey {
    
    _accessKey = accessKey;
    
    [[self requestSerializer] setValue:self.accessKey forHTTPHeaderField:@"accessKey"];
}

#pragma mark - API Methods

-(void)getDictionaries{
    
    [self GET:API_URL_DICTIONARIES parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if([[self delegate] respondsToSelector:@selector(CDHTTPSession:didReturnDictionariesList:)]){
            
            [[self delegate] CDHTTPSession:self didReturnDictionariesList:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

-(void)makeASearch:(NSString*)query{
    
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@?q=%@",API_URL_DICTIONARIES,API_URL_DEFAULT_DICTIONARY,API_URL_SEARCH,query];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if([[self delegate] respondsToSelector:@selector(CDHTTPSession:didReturnSearchResultList:)]){
            
            [[self delegate] CDHTTPSession:self didReturnSearchResultList:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

-(void)getAnEntry:(NSString*)entryId{
    
    NSString* url = [NSString stringWithFormat:@"%@/%@/%@/%@?format=xml",API_URL_DICTIONARIES,API_URL_DEFAULT_DICTIONARY,API_URL_ENTRIES,entryId];
    
    [self GET:url parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if([[self delegate] respondsToSelector:@selector(CDHTTPSession:didReturnEntry:)]){
            
            [[self delegate] CDHTTPSession:self didReturnEntry:responseObject];
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        
    }];
}

@end
