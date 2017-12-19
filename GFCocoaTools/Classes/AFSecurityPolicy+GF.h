//
//  AFSecurityPolicy.h
//  AFNetworking
//
//  Created by 熊国锋 on 2017/12/19.
//

#import <AFNetworking/AFNetworking.h>

NS_ASSUME_NONNULL_BEGIN

@interface AFSecurityPolicy (GF)

- (nullable NSSet<NSData *> *)certificatsWithUrl:(nullable NSURL *)url bucket:(NSString *)bucketAddress;

@end

NS_ASSUME_NONNULL_END
