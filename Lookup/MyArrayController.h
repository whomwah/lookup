//
//  MyArrayController.h
//  abFinder
//
//  Created by Duncan Robertson on 14/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class MyTableView;

@interface MyArrayController : NSArrayController {
	IBOutlet MyTableView *tableView;
}

- (BOOL)tableView:(NSTableView *)tv writeRowsWithIndexes:(NSIndexSet *)rowIndexes toPasteboard:(NSPasteboard*)pboard;

@end
