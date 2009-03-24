//
//  Contact.m
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "Contact.h"

@implementation Contact

@synthesize firstname, surname, email, uid, title, telephone, staffid, division, displayName, address;

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
    // Display Name
    if ([dict valueForKey:@"displayName"])
      self.displayName = [dict valueForKey:@"displayName"];
    // Firstname Name
    if ([dict valueForKey:@"givenName"])
      self.firstname = [dict valueForKey:@"givenName"];
    // Surname Name
    if ([dict valueForKey:@"sn"])
      self.surname = [dict valueForKey:@"sn"];
    // Email address
    if ([dict valueForKey:@"mail"])
      self.email = [[dict valueForKey:@"mail"] lowercaseString];
    // User login
    if ([dict valueForKey:@"mailNickname"])
      self.uid = [[dict valueForKey:@"mailNickname"] lowercaseString];
    // Telephone No
    if ([dict valueForKey:@"telephoneNumber"])
      self.telephone = [dict valueForKey:@"telephoneNumber"];
    // Division
    if ([dict valueForKey:@"division"])
      self.division = [dict valueForKey:@"division"];
    // Staff ID
    if ([dict valueForKey:@"employeeID"] && [[dict valueForKey:@"employeeID"] hasPrefix:@"UNKNOWN"] == NO)
      self.staffid = [dict valueForKey:@"employeeID"];
    // Job Title
    if ([dict valueForKey:@"title"])
      self.title = [dict valueForKey:@"title"];
    else
      self.title = @"Job Title Unknown";
    // Address
    if ([dict valueForKey:@"physicalDeliveryOfficeName"])
      self.address = [dict valueForKey:@"physicalDeliveryOfficeName"];
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

  [newPerson setValue:self.firstname forProperty:kABFirstNameProperty];
  [newPerson setValue:self.surname forProperty:kABLastNameProperty];
  [newPerson setValue:self.title forProperty:kABJobTitleProperty];
  [newPerson setValue:@"BBC" forProperty:kABOrganizationProperty];
  [newPerson setValue:kABShowAsPerson forProperty:kABPersonFlags];
  
  if (self.division)
    [newPerson setValue:self.division forProperty:kABDepartmentProperty];
  
  if (self.email) {
    ABMutableMultiValue *mv = [[ABMutableMultiValue alloc] init];
    [mv addValue:self.email withLabel:kABEmailWorkLabel];
    [mv setPrimaryIdentifier:kABEmailWorkLabel];
    [newPerson setValue:mv forProperty:kABEmailProperty];
    [mv release];
  }
  
  if (self.telephone) {
    ABMutableMultiValue *mv = [[ABMutableMultiValue alloc] init];
    [mv addValue:self.telephone withLabel:kABPhoneWorkLabel];
    [mv setPrimaryIdentifier:kABPhoneWorkLabel];
    [newPerson setValue:mv forProperty:kABPhoneProperty];
    [mv release];
  }
  
  if (self.address) {
    ABMutableMultiValue *mv = [[ABMutableMultiValue alloc] init];
    NSMutableDictionary *wAddr = [NSMutableDictionary dictionary];
    [wAddr setObject:self.address forKey: kABAddressStreetKey];
    [mv addValue:wAddr withLabel:kABAddressWorkLabel];
    [mv setPrimaryIdentifier:kABAddressWorkLabel];
    [newPerson setValue:mv forProperty:kABAddressProperty];
    [mv release];
  }
  
  if (self.staffid || self.uid) {
    ABMutableMultiValue *mv = [[ABMutableMultiValue alloc] init];
    if (self.staffid) 
      [mv addValue:self.staffid withLabel:@"staffId"];
    if (self.uid) 
      [mv addValue:self.uid withLabel:@"login"];
    
    [newPerson setValue:mv forProperty:kABRelatedNamesProperty];
    [mv release];
  }
  
  return [newPerson vCardRepresentation];
}

- (NSString *)name
{
  if (self.firstname && self.surname)
    return [NSString stringWithFormat:@"%@ %@", self.firstname, self.surname];
  else
    return self.displayName;
}

@end
