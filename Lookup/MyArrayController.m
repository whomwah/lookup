//
//  MyArrayController.m
//  abFinder
//
//  Created by Duncan Robertson on 14/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "MyArrayController.h"


@implementation MyArrayController

- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pb
{
	unsigned int row = [rowIndexes firstIndex];
	
	NSString *str = [[[self arrangedObjects] objectAtIndex:row] stringRepresentation];
	
	if (str == nil)
		return NO;
	
	NSArray *pboardTypes = [NSArray arrayWithObjects:NSStringPboardType, nil];
	[pb declareTypes:pboardTypes owner:self];
  [pb setString:str forType:NSStringPboardType];
	
	return YES;
}

- (void)awakeFromNib
{
	[tableView setDraggingSourceOperationMask:NSDragOperationCopy forLocal:NO];
}

@end
