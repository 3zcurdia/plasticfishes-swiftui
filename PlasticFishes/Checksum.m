//
//  Checksum.m
//  PlasticFishes
//
//  Created by Luis Ezcurdia on 19/09/22.
//

#import "Checksum.h"

@implementation Checksum
- (instancetype)init {
    if (self = [super init]) {
    }
    return self;
}

+(NSString *) sha1: (NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(str, (CC_LONG) strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH*2];
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}

+(NSString *) sha256: (NSString *)input {
    const char* str = [input UTF8String];
    unsigned char result[CC_SHA256_DIGEST_LENGTH];
    CC_SHA256(str, (CC_LONG) strlen(str), result);

    NSMutableString *ret = [NSMutableString stringWithCapacity:CC_SHA256_DIGEST_LENGTH*2];
    for(int i = 0; i < CC_SHA256_DIGEST_LENGTH; i++) {
        [ret appendFormat:@"%02x",result[i]];
    }
    return ret;
}
@end
