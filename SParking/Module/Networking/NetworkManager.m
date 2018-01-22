//
//  NetworkManager.m
//  SParking
//
//  Created by Yazhao on 2018/1/15.
//  Copyright © 2018年 Yazhao. All rights reserved.
//

#import "NetworkManager.h"

#define BASE_URL @"http://192.168.2.66:8000/api/ClientApp"

@implementation NetworkManager

#pragma mark - 初始化方法
+(instancetype)manager{
    return [[self alloc]init];;
}

-(void)startRequest{
    NSString *urlStr=[self urlWithPath:_path];
    NSString *paramStr=[self paramStringWithDictionary:_params];
    
    NSData *httpBody=nil;
    if(paramStr){
        if([_method isEqual:@"GET"]){
            urlStr=[NSString stringWithFormat:@"%@?%@",urlStr,paramStr];
        }else if([_method isEqual:@"POST"]){
            httpBody=[paramStr dataUsingEncoding:NSUTF8StringEncoding];
        }
    }
    
    //设置请求
    NSURLRequest *request=[self requestWithUrl:urlStr method:_method httpBody:httpBody];
    
    //创建请求任务
    [self resumeRequest:request];
}

#pragma mark - 内部方法
-(NSString*)urlWithPath:(NSString*)path{
    if(path){
        return [NSString stringWithFormat:@"%@/%@",BASE_URL,path];
    }
    
    return BASE_URL;
}
-(NSString*)paramStringWithDictionary:(NSDictionary*)dict{
    if(dict){
        NSMutableString *ret=[[NSMutableString alloc]init];
        for (NSString *key in dict.allKeys) {
            id value=dict[key];
            NSString *param=[NSString stringWithFormat:@"%@=%@&",key,value];
            [ret appendString:param];
        }
        [ret deleteCharactersInRange:NSMakeRange(ret.length-1, 1)];
        return ret;
    }
    
    return nil;
}

-(NSURLRequest*)requestWithUrl:(NSString*)url method:(NSString*)method httpBody:(NSData*)body{
    NSURL *URL=[NSURL URLWithString:url];
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:URL];
    
    //设置请求头
    [request addValue:@"IOS" forHTTPHeaderField:@"Platform"];
    [request addValue:@"1.0.0" forHTTPHeaderField:@"Version"];
    [request addValue:@"1111" forHTTPHeaderField:@"Appid"];
    request.HTTPMethod=method;
    request.timeoutInterval=3.0;
    
    if(body){
        request.HTTPBody=body;
    }
    
    return request;
}

-(void)resumeRequest:(NSURLRequest*)request{
    __block NetworkManager *tself=self;
    
    NSURLSession *session=[NSURLSession sharedSession];
    NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if(error){
            _response(nil,error);
            return;
        }
        [tself dealRequestData:data];
    }];
    [task resume];
}


-(void)dealRequestData:(NSData*)data{
    NSError *error=nil;
    NSMutableDictionary *jsonDict=[NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableContainers) error:&error];
    
    if(error){
        _response(nil,error);
        return;
    }
    
    _response(jsonDict,nil);
    return;
}
@end
