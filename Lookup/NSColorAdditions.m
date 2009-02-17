//
//  NSColorAdditions.h
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "NSColorAdditions.h"

@implementation NSColor (CustomAlternatingRowBackgroundColors)

+ (NSArray *)controlAlternatingRowBackgroundColors 
{
	NSColor * anEvenRowColor = [NSColor colorWithDeviceWhite:.95 alpha:1.0];
	NSColor * anOddRowColor = [NSColor colorWithDeviceWhite:.85 alpha:1.0];
	return [NSArray arrayWithObjects:anEvenRowColor, anOddRowColor, nil];
}

@end
