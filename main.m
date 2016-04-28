//
//  main.m
//  CookieClear
//
//  Created by Douglas Hill on 19/07/2013.
//

#import <Foundation/Foundation.h>

@interface NSHTTPCookie (DHAdditions)

- (NSString *)dh_description;

@end

@implementation NSHTTPCookie (DHAdditions)

- (NSString *)dh_description
{
	return [NSString stringWithFormat:@"%@ %@ : %@",
			[[self domain] stringByPaddingToLength:20 withString:@" " startingAtIndex:0],
			[[self name] stringByPaddingToLength:10 withString:@" " startingAtIndex:0],
			[[self value] stringByPaddingToLength:50 withString:@" " startingAtIndex:0]];
}

@end

int main(int argc, const char * argv[])
{
	@autoreleasepool {
		
        NSArray *whiteListedDomains = @[@"p03-quota.icloud.com", @"instapaper.com", @"overcast.fm", @"feedwrangler.net", @"github.com", @"stackoverflow.com", @"stackexchange.com", @"slack.com"];
		
		NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
		
		for (NSHTTPCookie *cookie in [storage cookies]) {
			
			BOOL shouldDeleteCookie = YES;
			
			for (NSString *whiteListedDomain in whiteListedDomains) {
				if ([[cookie domain] hasSuffix:whiteListedDomain]) shouldDeleteCookie = NO;
			}
			
			if (shouldDeleteCookie) {
				NSLog(@"Deleting: %@", [cookie dh_description]);
				[storage deleteCookie:cookie];
			}
		}
	}
	
	return 0;
}
