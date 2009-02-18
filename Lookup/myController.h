//
//  MyController.h
//  TableTest
//
//  Created by Duncan Robertson on 06/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const DSRLdapServer;
extern NSString * const DSRBaseSearch;
extern NSString * const DSRMaxResults;
extern NSString * const DRSSearchString;

@interface MyController : NSWindowController {
  NSMutableArray *contactList;
  
  IBOutlet NSTableView *contactTable;
  IBOutlet NSSearchField *searchField;
  IBOutlet NSProgressIndicator *pi;
  IBOutlet NSTextField *statusText;
}

@property(nonatomic, retain) NSMutableArray *contactList;

- (IBAction)startSearch:(id)sender;
- (void)updateStatusTextWith:(NSString*)str;

@end
