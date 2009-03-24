//
//  MyTableView.h
//  abFinder
//
//  Created by Duncan Robertson on 01/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface MyTableView : NSTableView 
{
	NSColor *mHighlightColorInFocusView;
	NSColor *mHighlightColorOutOfFocusView;
  NSEvent *mouseDownEvent;
}

- (void)highlightSelectionInClipRect:(NSRect)theClipRect;
- (IBAction)copy:(id)sender;
- (void)writeToPasteboard:(NSPasteboard*)pb;
- (NSDragOperation)draggingSourceOperationMaskForLocal:(BOOL)isLocal;

@end
