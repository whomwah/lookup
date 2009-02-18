//
//  MyController.m
//  TableTest
//
//  Created by Duncan Robertson on 06/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "MyController.h"
#import "MyCell.h"
#import "Contact.h"
#import "NSString-Utilities.h"

NSString * const DSRLdapServer = @"LdapServer";
NSString * const DSRBaseSearch = @"BaseSearch";
NSString * const DSRMaxResults = @"MaxResults";
NSString * const DRSSearchString = @"SearchString";

@implementation MyController

@synthesize contactList;

- (id)init {
	if (self = [super init]) {
    contactList = [NSMutableArray array];
	}
	return self;
}

- (void) awakeFromNib {	
	MyCell *cell = [[[MyCell alloc] init] autorelease];
	[[contactTable tableColumnWithIdentifier:@"theTableColumn"] setDataCell:cell];
}

- (IBAction)startSearch:(id)sender
{
  NSString *searchString = [sender stringValue];
  [self updateStatusTextWith:@""];
  
  if ([searchString isEqualToString:@""] == NO) {
    [contactList removeAllObjects];
    self.contactList = contactList;
    [pi startAnimation:sender];
    NSTask *task = [[NSTask alloc] init];
/*
    [task setLaunchPath:@"/usr/bin/ldapsearch"];
    
    NSString *cmdString = [NSString stringWithFormat:[[NSUserDefaults standardUserDefaults] stringForKey:DRSSearchString], 
                           searchString, searchString, searchString, searchString, searchString];
    NSArray *args = [NSArray arrayWithObjects:@"-Q", @"-LLL",
                     @"-Y", @"GSSAPI", 
                     @"-s", @"sub", 
                     @"-z", [[NSUserDefaults standardUserDefaults] stringForKey:DSRMaxResults], 
                     @"-h", [[NSUserDefaults standardUserDefaults] stringForKey:DSRLdapServer],
                     @"-b", [[NSUserDefaults standardUserDefaults] stringForKey:DSRBaseSearch],
                     cmdString, @"displayName", @"mail", @"mailNickname", @"title", @"telephoneNumber", @"employeeID",
                     nil];
*/
    [task setLaunchPath:@"/bin/cat"];
    NSArray *args = [NSArray arrayWithObjects:@"/Users/duncan/dump.txt", nil];

    NSPipe *outpipe = [[NSPipe alloc] init];
    NSPipe *errorOutpipe = [[NSPipe alloc] init];
    
    [task setArguments:args];
    [task setStandardOutput:outpipe];
    [task setStandardError:errorOutpipe];
    [outpipe release];
    [errorOutpipe release];
    [task launch];
    
    NSData *data = [[outpipe fileHandleForReading] readDataToEndOfFile];
    NSData *errorData = [[errorOutpipe fileHandleForReading] readDataToEndOfFile];
    
    [task waitUntilExit];
    int status = [task terminationStatus];
    
    if (status == 0) {
      
      NSLog(@"Success..results found");
      NSString *aString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
      
      [task release];
      [pi stopAnimation:sender];
      
      Contact *c;
      NSMutableDictionary *contactDict = [NSMutableDictionary dictionary];
      int has_result = 0;
      
      NSArray *lines = [aString componentsSeparatedByString:@"\n\n"];
      
      for (NSString *line in lines) {
        NSArray *fields = [line componentsSeparatedByString:@"\n"];
        for (NSString *field in fields) {
          NSArray *keys = [NSArray arrayWithObjects:@"displayName", @"mail", @"title", 
                           @"telephoneNumber", @"mailNickname", @"employeeID", nil];
          
          for (NSString *key in keys) {
            if ([field hasPrefix:[key stringByAppendingString:@": "]] == YES) {
              NSString *str = [field stringAfterSeparator:@": "];
              if ([str length] < 2)
                str = nil;
              
              [contactDict setValue:str forKey:key];
              has_result = 1;
            }  
          }
        }
        
        if (has_result == 1 && 
            [contactDict valueForKey:@"displayName"] &&
            [contactDict valueForKey:@"mail"] &&
            [[contactDict valueForKey:@"displayName"] hasPrefix:@"_"] == NO &&
            [[contactDict valueForKey:@"displayName"] hasPrefix:@"System"] == NO) {
          c = [[Contact alloc] initWithContactDict:contactDict];
          [contactList addObject:c];
          [c release];
          [contactDict removeAllObjects];
        }
        
        has_result = 0;
      }
      
      self.contactList = contactList;    
      [self updateStatusTextWith:[NSString stringWithFormat:@"%d results found", [contactList count]]];
      [aString release];
      
    } else {
      
      NSAlert *alert = [[[NSAlert alloc] init] autorelease];
      NSString *err = [[NSString alloc] initWithData:errorData encoding:NSUTF8StringEncoding];
      
      [pi stopAnimation:sender];
      [alert addButtonWithTitle:@"OK"];
      [alert setMessageText:@"Oops! something broke?"];
      [alert setInformativeText:[NSString stringWithFormat:@"%@", err]];
      [alert setAlertStyle:NSWarningAlertStyle];
      [alert beginSheetModalForWindow:[contactTable window]
                        modalDelegate:self 
                       didEndSelector:nil 
                          contextInfo:nil];
      [err release];
    }
  }
}

- (void)updateStatusTextWith:(NSString*)str
{
  NSShadow *shadow = [[NSShadow alloc] init];
  [shadow setShadowColor:[NSColor colorWithDeviceWhite:1.0 alpha:0.5]];
  [shadow setShadowOffset:NSMakeSize(1.0, -1.1)];
  
  NSMutableDictionary *sAttribs = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                        [NSFont systemFontOfSize:11.0],NSFontAttributeName,
                        shadow, NSShadowAttributeName,
                        nil] autorelease];
  [shadow release];
  
  NSAttributedString *s = [[NSAttributedString alloc] initWithString:str attributes:sAttribs];
  [statusText setAttributedStringValue:s];
  [s release];
}

@end
