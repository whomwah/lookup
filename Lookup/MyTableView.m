//
//  MyTableView.h
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "MyTableView.h"

@implementation MyTableView

- (void)awakeFromNib
{
	mHighlightColorInFocusView = [[NSColor colorWithDeviceRed:.263 green:.424 blue:.839 alpha:1.0] retain];
	mHighlightColorOutOfFocusView = [[NSColor colorWithDeviceRed:.584 green:.659 blue:.753 alpha:1.0] retain];
}

- (void)dealloc
{
	[mHighlightColorInFocusView release];
	[mHighlightColorOutOfFocusView release];
	
	[super dealloc];
}

- (void)highlightSelectionInClipRect:(NSRect)theClipRect
{
	
	NSRange aVisibleRowIndexes = [self rowsInRect:theClipRect];
	NSIndexSet *aSelectedRowIndexes = [self selectedRowIndexes];
	int aRow = aVisibleRowIndexes.location;
	int	anEndRow = aRow + aVisibleRowIndexes.length;
	
	// if the view is focused, use highlight color, otherwise use the out-of-focus highlight color
	if (self == [[self window] firstResponder] && [[self window] isMainWindow] && [[self window] isKeyWindow])
		[mHighlightColorInFocusView set];
	else
		[mHighlightColorOutOfFocusView set];
	
	// draw highlight for the visible, selected rows
    for (aRow; aRow < anEndRow; aRow++) {
      if([aSelectedRowIndexes containsIndex:aRow]) {
        NSRect aRowRect = NSInsetRect([self rectOfRow:aRow], 5, 3);
        [[NSBezierPath bezierPathWithRoundedRect:aRowRect xRadius:5.0 yRadius:5.0] fill];
      }
    }
}

- (IBAction)copy:(id)sender
{
  NSPasteboard *pb = [NSPasteboard generalPasteboard];
  [self writeToPasteboard:pb];
}

- (void)writeToPasteboard:(NSPasteboard*)pb
{
  NSString *str = [[[[self tableColumnWithIdentifier:@"theTableColumn"] 
      dataCellForRow:[self selectedRow]] objectValue] stringRepresentation];

  [pb declareTypes:[NSArray arrayWithObject:NSStringPboardType] owner:self];
  [pb setString:str forType:NSStringPboardType];

}

- (NSImage *)dragImageForRowsWithIndexes:(NSIndexSet *)dragRows 
                            tableColumns:(NSArray *)tableColumns 
                                   event:(NSEvent *)dragEvent 
                                  offset:(NSPointPointer)dragImageOffset
{
  return [[NSWorkspace sharedWorkspace] iconForFileType:@"vcf"];
}

- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal
{
  return NSDragOperationCopy;
}

- (void)mouseDown:(NSEvent *)event
{
  [super mouseDown:event];
  if([event clickCount] == 2) {
    NSString *str = [[[[self tableColumnWithIdentifier:@"theTableColumn"] 
                       dataCellForRow:[self selectedRow]] objectValue] stringRepresentation];
    NSString *encodedTo = [str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *encodedURLString = [NSString stringWithFormat:@"mailto:%@", encodedTo];
    NSURL *mailtoURL = [NSURL URLWithString:encodedURLString];
    [[NSWorkspace sharedWorkspace] openURL:mailtoURL];
  }
}

@end
