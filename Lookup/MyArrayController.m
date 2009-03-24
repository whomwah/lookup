//
//  MyArrayController.m
//  abFinder
//
//  Created by Duncan Robertson on 14/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "MyArrayController.h"
#import "Contact.h"

@implementation MyArrayController

- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes 
     toPasteboard:(NSPasteboard*)pb
{
	unsigned int row = [rowIndexes firstIndex];
	
	NSString *str = [[[self arrangedObjects] objectAtIndex:row] stringRepresentation];
	
	if (str == nil)
		return NO;
  
  NSData *data = [[[self arrangedObjects] objectAtIndex:row] vCardDataRepresentation];
	
	NSArray *pboardTypes = [NSArray arrayWithObjects:NSStringPboardType, NSVCardPboardType, 
                          NSFilesPromisePboardType, nil];
	[pb declareTypes:pboardTypes owner:self];
  [pb setString:str forType:NSStringPboardType];
  [pb setData:data forType:NSVCardPboardType];
  
  NSArray *prom = [NSArray arrayWithObject:str];  
  [pb setPropertyList:prom forType:NSFilesPromisePboardType];
  
	return YES;
}

- (NSArray *)tableView:(NSTableView *)aTableView 
  namesOfPromisedFilesDroppedAtDestination:(NSURL *)dropDestination 
  forDraggedRowsWithIndexes:(NSIndexSet *)indexSet
{
  unsigned int row = [indexSet firstIndex];
  NSData *data = [[[self arrangedObjects] objectAtIndex:row] vCardDataRepresentation];
  NSString *fn = [[[self arrangedObjects] objectAtIndex:row] displayName];
  NSString *path = [NSString stringWithFormat:@"%@/%@.vcf", [dropDestination path], fn];
  NSString *op = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
  
  [op writeToFile:path 
       atomically:NO 
         encoding:NSUTF8StringEncoding 
            error:nil];
  
  [op release];

  return [NSArray arrayWithObject:fn];
}

- (void)awakeFromNib
{
	[tableView setDraggingSourceOperationMask:NSDragOperationCopy forLocal:NO];
}

@end
