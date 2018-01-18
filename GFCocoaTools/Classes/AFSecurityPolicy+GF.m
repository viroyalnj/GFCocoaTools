//
//  AFSecurityPolicy.m
//  AFNetworking
//
//  Created by 熊国锋 on 2017/12/19.
//

#import "AFSecurityPolicy+GF.h"
#import "NSString+GF.h"

@implementation AFSecurityPolicy (GF)

- (NSSet<NSData *> *)certificatsWithUrl:(NSURL *)url bucket:(NSString *)bucketAddress {
    NSString *scheme = url.scheme;
    NSString *host = url.host;
    if ([scheme isEqualToString:@"https"]) {
        NSURL *sslFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
        sslFolder = [sslFolder URLByAppendingPathComponent:@"ssl" isDirectory:YES];
        [[NSFileManager defaultManager] createDirectoryAtURL:sslFolder withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString *string = [NSString stringWithFormat:@"%@/%@.cer", bucketAddress, host];
        NSString *key = [NSString stringWithFormat:@"%@.cer", host];
        NSURL *localUrl = [sslFolder URLByAppendingPathComponent:key];
        NSData *data = [NSData dataWithContentsOfURL:localUrl];
        if (!data) {
            data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
            if (data) {
                [data writeToURL:localUrl atomically:YES];
            }
            else {
                NSLog(@"*** cert file download failed! ***");
            }
        }
        
        NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:sslFolder
                                                                 includingPropertiesForKeys:nil
                                                                                    options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                               errorHandler:nil];
        
        NSMutableSet *set = [NSMutableSet set];
        for (NSURL *item in enumerator) {
            NSData *data = [NSData dataWithContentsOfURL:item];
            if (data) {
                [set addObject:data];
            }
        }
        
        return set.copy;
    }
    
    return nil;
}

@end
