//
//  Contact.h
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Contact : NSObject {
  NSString *name;
  NSString *email;
  NSString *uid;
  NSString *telephone;
  NSString *title;
  NSString *staffid;
}

@property(nonatomic, copy) NSString *name;
@property(nonatomic, copy) NSString *email;
@property(nonatomic, copy) NSString *uid;
@property(nonatomic, copy) NSString *telephone;
@property(nonatomic, copy) NSString *title;
@property(nonatomic, copy) NSString *staffid;

- (id)initWithContactDict:(NSDictionary *)dict;
- (NSString*)stringRepresentation;

@end
