//
//  main.m
//  CookieClear
//
//  Created by Douglas Hill on 19/07/2013.
//

#import <Foundation/Foundation.h>

@interface NSHTTPCookie (DHAdditions)

- (NSString *)DHDescription;

@end

@implementation NSHTTPCookie (DHAdditions)

- (NSString *)DHDescription
{
	return [NSString stringWithFormat:@"%@ %@ : %@",
			[[self domain] stringByPaddingToLength:20 withString:@" " startingAtIndex:0],
			[[self name] stringByPaddingToLength:10 withString:@" " startingAtIndex:0],
			[self value]];
}

@end

int main(int argc, const char * argv[])
{
	@autoreleasepool {
		
		NSArray *whiteListedDomains = @[@"instapaper.com", @"feedwrangler.net", @"github.com"];
		
		NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
		
		for (NSHTTPCookie *cookie in [storage cookies]) {
			
			BOOL shouldDeleteCookie = YES;
			
			for (NSString *whiteListedDomain in whiteListedDomains) {
				if ([[cookie domain] hasSuffix:whiteListedDomain]) shouldDeleteCookie = NO;
			}
			
			if (shouldDeleteCookie) {
				NSLog(@"Deleting: %@", [cookie DHDescription]);
				[storage deleteCookie:cookie];
			}
		}
	}
	
	return 0;
}
