//
//  SDImageCache.m
//  AFNetworking
//
//  Created by 熊国锋 on 2017/11/30.
//

#import "SDImageCache+GF.h"
#import "ArchiveManager.h"

@implementation SDImageCache (GF)

- (void)pushDefaultData:(NSURL *)url {
    NSURL *cache = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject];
    cache = [cache URLByAppendingPathComponent:@"tmp" isDirectory:YES];
    
    NSString *string = [self defaultCachePathForKey:@"aa"];
    NSURL *desti = [NSURL fileURLWithPath:string];
    desti = [desti URLByDeletingLastPathComponent];
    
    [[NSFileManager defaultManager] createDirectoryAtURL:desti
                             withIntermediateDirectories:YES
                                              attributes:nil
                                                   error:nil];
    
    [[ArchiveManager manager] unzipFile:[url path]
                            destination:[cache path]
                            complection:^(BOOL success, NSString * _Nonnull destination) {
                                if (success) {
                                    NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtURL:[NSURL fileURLWithPath:destination isDirectory:YES]
                                                                                             includingPropertiesForKeys:nil
                                                                                                                options:NSDirectoryEnumerationSkipsSubdirectoryDescendants | NSDirectoryEnumerationSkipsPackageDescendants | NSDirectoryEnumerationSkipsHiddenFiles
                                                                                                           errorHandler:nil];
                                    
                                    for (NSURL *item in enumerator) {
                                        NSString *name = [item lastPathComponent];
                                        
                                        [[NSFileManager defaultManager] moveItemAtURL:item toURL:[desti URLByAppendingPathComponent:name] error:nil];
                                    }
                                }
                            }];
}

@end
