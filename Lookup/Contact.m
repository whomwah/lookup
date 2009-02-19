//
//  Contact.m
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "Contact.h"

@implementation Contact

@synthesize name, email, uid, title, telephone, staffid;

- (id)init
{
  [self dealloc];
  @throw [NSException exceptionWithName:@"DSRBadInitCall" 
                                 reason:@"Initialize Contact with initWithContactDict:" 
                               userInfo:nil];
  return nil;
}

- (id)initWithContactDict:(NSDictionary *)dict
{
	if (self = [super init]) {
    // Full Name
    if ([dict valueForKey:@"displayName"])
      self.name = [dict valueForKey:@"displayName"];
    // Email address
    if ([dict valueForKey:@"mail"])
      self.email = [[dict valueForKey:@"mail"] lowercaseString];
    // User login
    if ([dict valueForKey:@"mailNickname"])
      self.uid = [[dict valueForKey:@"mailNickname"] lowercaseString];
    // Telephone No
    if ([dict valueForKey:@"telephoneNumber"])
      self.telephone = [dict valueForKey:@"telephoneNumber"];
    // Staff ID
    if ([dict valueForKey:@"employeeID"] && [[dict valueForKey:@"employeeID"] hasPrefix:@"UNKNOWN"] == NO)
      self.staffid = [dict valueForKey:@"employeeID"];
    // Job Title
    if ([dict valueForKey:@"title"])
      self.title = [dict valueForKey:@"title"];
    else
      self.title = @"Job Title Unknown";
	}
	return self;
}

- (NSString*)stringRepresentation
{
  return [NSString stringWithFormat:@"%@ <%@>", self.name, self.email];
}

- (NSData*)vCardDataRepresentation
{   
  ABPerson *newPerson = [[[ABPerson alloc] init] autorelease];
  [newPerson setValue:self.name forProperty:kABFirstNameProperty];
  [newPerson setValue:self.name forProperty:kABLastNameProperty];
  //[newPerson setValue:self.email forProperty:kABEmailProperty];
  //[newPerson setValue:self.telephone forProperty:kABPhoneProperty];
  NSLog(@"%@", [newPerson vCardRepresentation]);
  return [newPerson vCardRepresentation];
}

@end
