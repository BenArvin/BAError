//
//  NSError+BAError.m
//  BAError
//
//  Created by benarvin on 2020/7/17.
//

#import "NSError+BAError.h"

static NSString *const kBAErrorUnknown = @"Unknown";
static NSString *const kBAErrorDomainKey = @"Domain";
static NSString *const kBAErrorCodeKey = @"Code";
static NSString *const kBAErrorDescriptionKey = @"Description";
static NSString *const kBAErrorReasonKey = @"Reason";
static NSString *const kBAErrorSuggestionKey = @"Suggestion";
static NSString *const kBAErrorCausesKey = @"Causes";

@implementation NSError (BAError)

+ (NSError *)bae_errorWith:(NSString *)domain code:(NSInteger)code causes:(NSError *)item,...NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *causesItems = nil;
    va_list arguments;
    NSError *eachItem;
    if (item) {
        causesItems = [[NSMutableArray alloc] init];
        [causesItems addObject:item];
        va_start(arguments, item);
        while ((eachItem = va_arg(arguments, NSError *))) {
            [causesItems addObject:eachItem];
        }
        va_end(arguments);
    }
    return [self bae_errorWith:domain code:code description:nil reason:nil recoverySuggestion:nil causesItems:causesItems];
}

+ (NSError *)bae_errorWith:(NSString *)domain code:(NSInteger)code description:(NSString *)description causes:(NSError *)item,...NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *causesItems = nil;
    va_list arguments;
    NSError *eachItem;
    if (item) {
        causesItems = [[NSMutableArray alloc] init];
        [causesItems addObject:item];
        va_start(arguments, item);
        while ((eachItem = va_arg(arguments, NSError *))) {
            [causesItems addObject:eachItem];
        }
        va_end(arguments);
    }
    return [self bae_errorWith:domain code:code description:description reason:nil recoverySuggestion:nil causesItems:causesItems];
}

+ (NSError *)bae_errorWith:(NSString *)domain code:(NSInteger)code description:(NSString *)description reason:(NSString *)reason causes:(NSError *)item,...NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *causesItems = nil;
    va_list arguments;
    NSError *eachItem;
    if (item) {
        causesItems = [[NSMutableArray alloc] init];
        [causesItems addObject:item];
        va_start(arguments, item);
        while ((eachItem = va_arg(arguments, NSError *))) {
            [causesItems addObject:eachItem];
        }
        va_end(arguments);
    }
    return [self bae_errorWith:domain code:code description:description reason:reason recoverySuggestion:nil causesItems:causesItems];
}

+ (NSError *)bae_errorWith:(NSString *)domain code:(NSInteger)code description:(NSString *)description reason:(NSString *)reason recoverySuggestion:(NSString *)recoverySuggestion causes:(NSError *)item,...NS_REQUIRES_NIL_TERMINATION {
    NSMutableArray *causesItems = nil;
    va_list arguments;
    NSError *eachItem;
    if (item) {
        causesItems = [[NSMutableArray alloc] init];
        [causesItems addObject:item];
        va_start(arguments, item);
        while ((eachItem = va_arg(arguments, NSError *))) {
            [causesItems addObject:eachItem];
        }
        va_end(arguments);
    }
    return [self bae_errorWith:domain code:code description:description reason:reason recoverySuggestion:recoverySuggestion causesItems:causesItems];
}

#pragma mark - private methods
+ (NSError *)bae_errorWith:(NSString *)domain code:(NSInteger)code description:(NSString *)description reason:(NSString *)reason recoverySuggestion:(NSString *)recoverySuggestion causesItems:(NSArray <NSError *> *)causesItems {
    NSString *domainTmp = domain ? domain : kBAErrorUnknown;
    NSString *desTmp = [self bae_buildDes:domain code:code des:description];
    
    NSMutableDictionary *fullDic = [[NSMutableDictionary alloc] init];
    [fullDic setObject:domainTmp forKey:kBAErrorDomainKey];
    [fullDic setObject:@(code) forKey:kBAErrorCodeKey];
    if (description) {
        [fullDic setObject:description forKey:kBAErrorDescriptionKey];
    }
    if (reason) {
        [fullDic setObject:reason forKey:kBAErrorReasonKey];
    }
    if (recoverySuggestion) {
        [fullDic setObject:recoverySuggestion forKey:kBAErrorSuggestionKey];
    }
    
    NSMutableArray *causeDics = nil;
    for (NSError *item in causesItems) {
        if (!causeDics) {
            causeDics = [[NSMutableArray alloc] init];
        }
        [causeDics addObject:[self bae_toDic:item]];
    }
    if (causeDics) {
        [fullDic setObject:causeDics forKey:kBAErrorCausesKey];
    }
    NSString *fullStr = [self bae_toJsonStr:fullDic];
    return [NSError errorWithDomain:domainTmp code:code userInfo:@{
        NSLocalizedDescriptionKey: desTmp,
        NSLocalizedFailureReasonErrorKey: fullStr,
        NSLocalizedRecoverySuggestionErrorKey: fullStr
    }];
}

+ (NSString *)bae_toJsonStr:(NSDictionary *)dic {
    if (!dic) {
        return nil;
    }
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
    if (!jsonData || error) {
        return nil;
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (id)bae_toDic:(NSError *)error {
    NSString *reason = [error localizedFailureReason];
    if (!reason) {
        reason = [self bae_buildDes:error.domain code:error.code des:error.localizedDescription];
    }
    NSError *errorTmp;
    id result = [NSJSONSerialization JSONObjectWithData:[reason dataUsingEncoding:NSUTF8StringEncoding] options:0 error:&errorTmp];
    return errorTmp ? reason : (NSDictionary *)result;
}

+ (NSString *)bae_buildDes:(NSString *)domain code:(NSInteger)code des:(NSString *)des {
    return [NSString stringWithFormat:@"[%@-%ld] %@", domain?:kBAErrorUnknown, (long)code, des?:kBAErrorUnknown];
}

@end
