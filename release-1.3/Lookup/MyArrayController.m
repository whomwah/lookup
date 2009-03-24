//
//  MyArrayController.m
//  abFinder
//
//  Created by Duncan Robertson on 14/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "MyArrayController.h"
#import "MyTableView.h"
#import "Contact.h"

@implementation MyArrayController

- (BOOL)tableView:(NSTableView *)tv 
writeRowsWithIndexes:(NSIndexSet *)rowIndexes 
     toPasteboard:(NSPasteboard*)pboard
{
  NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
  Contact *c = [[[tableView tableColumnWithIdentifier:@"theTableColumn"] 
                 dataCellForRow:[tv selectedRow]] objectValue];
  
  [pb declareTypes:[NSArray arrayWithObjects:
                    NSStringPboardType, 
                    @"Apple VCard pasteboard type", 
                    nil] owner:nil];
  [pb setString:[c stringRepresentation] forType:NSStringPboardType];
  [pb setData:[c vCardDataRepresentation] forType:@"Apple VCard pasteboard type"];
  
  //[pb declareTypes:[NSArray arrayWithObject:NSFileContentsPboardType] owner:nil];
  
  //NSData *d = [[[[tableView tableColumnWithIdentifier:@"theTableColumn"] 
  //               dataCellForRow:[tv selectedRow]] objectValue] vCardDataRepresentation];
  /*  
  NSFileWrapper *w = [[NSFileWrapper alloc] initWithSerializedRepresentation:d];
  [w setPreferredFilename:@"duncan.vcf"];
  NSPasteboard *pb = [NSPasteboard pasteboardWithName:NSDragPboard];
  [pb declareTypes:[NSArray arrayWithObject:NSFileContentsPboardType] owner:nil];
  [pb writeFileWrapper:w];

   NSData *d = [[[[self tableColumnWithIdentifier:@"theTableColumn"] 
   dataCellForRow:[self selectedRow]] objectValue] vCardDataRepresentation];
   
   NSPropertyListFormat format;
   NSPropertyListSerialization *f = [NSPropertyListSerialization propertyListFromData:d
   mutabilityOption:NSPropertyListImmutable
   format:&format
   errorDescription:nil];
  [pb declareTypes:[NSArray arrayWithObjects:NSStringPboardType, 
                    @"Apple VCard pasteboard type", 
                    @"public.vcard", 
                    @"NSPromiseContentsPboardType",
                    @"ABPeopleUIDsPboardType",
                    NSFileContentsPboardType,
                    @"Apple files promise pasteboard type",
                    nil] owner:self];
  [pb setString:str forType:NSStringPboardType];
  [pb setData:d forType:@"Apple VCard pasteboard type"];
  [pb setData:d forType:@"public.vcard"];
  [pb setData:d forType:@"ABPeopleUIDsPboardType"];
  [pb setPropertyList:f forType:@"NSPromiseContentsPboardType"];
  [pb setPropertyList:f forType:NSFileContentsPboardType];
  [pb setPropertyList:f forType:@"Apple files promise pasteboard type"];
  */
  return YES;
}

@end
