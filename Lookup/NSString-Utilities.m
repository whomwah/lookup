//
//  NSString-Utilities.m
//  MiProgrammes
//
//  Created by Duncan Robertson on 10/06/2008.
//  Copyright 2008 Whomwah. All rights reserved.
//

#import "NSString-Utilities.h"

@implementation NSString (Utilities)

- (NSString *)stringAfterSeparator:(NSString *)seperator
{
  NSArray *parts = [self componentsSeparatedByString:seperator];
  int last = [parts count] - 1;
  return [parts objectAtIndex:last];
}

@end
