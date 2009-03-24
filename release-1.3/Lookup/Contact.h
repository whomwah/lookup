//
//  Contact.h
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <AddressBook/AddressBook.h>

@interface Contact : NSObject {
  NSString *displayName;
  NSString *firstname;
  NSString *surname;
  NSString *email;
  NSString *uid;
  NSString *telephone;
  NSString *title;
  NSString *staffid;
  NSString *division;
  NSString *address;
}

@property(nonatomic, copy) NSString *displayName;
@property(nonatomic, copy) NSString *firstname;
@property(nonatomic, copy) NSString *surname;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *telephone;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *staffid;
@property(nonatomic, copy) NSString *division;
@property(nonatomic, copy) NSString *address;

- (id)initWithContactDict:(NSDictionary *)dict;
- (NSString *)stringRepresentation;
- (NSData *)vCardDataRepresentation;
- (NSString *)name;

@end
