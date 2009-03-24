//
//  MyArrayController.h
//  abFinder
//
//  Created by Duncan Robertson on 14/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface MyArrayController : NSArrayController {
	IBOutlet NSTableView *tableView;
}

//- (BOOL)tableView:(NSTableView *)aTableView writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard;

@end
