//
//  AFSecurityPolicy.m
//  AFNetworking
//
//  Created by 熊国锋 on 2017/12/19.
//

#import "AFSecurityPolicy+GF.h"
#import "NSString+GF.h"

@implementation AFSecurityPolicy (GF)

- (NSSet<NSData *> *)certificatsWithAddress:(NSString *)string {
    NSURL *url = [NSURL URLWithString:string];
    NSURL *sslFolder = [[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask].firstObject;
    sslFolder = [sslFolder URLByAppendingPathComponent:@"ssl" isDirectory:YES];
    if (url) {
        [[NSFileManager defaultManager] createDirectoryAtURL:sslFolder withIntermediateDirectories:YES attributes:nil error:nil];
        
        NSString *key = [NSString stringWithFormat:@"%@.cer", [string MD5InShort]];
        NSURL *localUrl = [sslFolder URLByAppendingPathComponent:key];
        if (![[NSFileManager defaultManager] fileExistsAtPath:localUrl.path]) {
            NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:string]];
            if (data) {
                [data writeToURL:localUrl atomically:YES];
            }
            else {
                NSLog(@"*** cert file download failed! ***");
            }
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

@end
