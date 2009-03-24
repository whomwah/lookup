//
//  MyCell.m
//  abFinder
//
//  Created by Duncan Robertson on 07/02/2009.
//  Copyright 2009 Whomwah. All rights reserved.
//

#import "MyCell.h"
#import "Contact.h"

@implementation MyCell

- (void)setObjectValue:(id )object {
  id oldObjectValue = [self objectValue];
  if (object != oldObjectValue) {
    [object retain];
    [oldObjectValue release];
    [super setObjectValue:[NSValue valueWithNonretainedObject:object]];
  }
}

- (id)objectValue {
  return [[super objectValue] nonretainedObjectValue];
}

- (void)drawInteriorWithFrame:(NSRect)theCellFrame inView:(NSView *)theControlView
{
  Contact *data = [self objectValue];
	
	NSRect anInsetRect = NSInsetRect(theCellFrame,5,0);
	NSImage *anIcon = [NSImage imageNamed:NSImageNameUser];
	[anIcon setFlipped:YES];
	NSSize anIconSize = [anIcon size];
	
	// Make attributes for our strings
	NSMutableParagraphStyle *aParagraphStyle = [[[NSMutableParagraphStyle alloc] init] autorelease];
	[aParagraphStyle setLineBreakMode:NSLineBreakByTruncatingTail];
	
	// system font, 14pt, truncate tail
	NSMutableDictionary *nameAttrib = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                    [NSFont boldSystemFontOfSize:14.0],NSFontAttributeName,
                                    aParagraphStyle, NSParagraphStyleAttributeName,
                                    nil] autorelease];
  
	// system font, 12pt, truncate tail
	NSMutableDictionary *emailAttrib = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                     [NSFont boldSystemFontOfSize:11.0],NSFontAttributeName,
                                     aParagraphStyle, NSParagraphStyleAttributeName,
                                     nil] autorelease];
  
  // system font, 9pt, truncate tail
	NSMutableDictionary *miniTextAttrib = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                   [NSFont boldSystemFontOfSize:10.0],NSFontAttributeName,
                                   aParagraphStyle, NSParagraphStyleAttributeName,
                                   nil] autorelease];
  
  // system font, 9pt, truncate tail
	NSMutableDictionary *miniText1Attrib = [[[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                          [NSFont systemFontOfSize:10.0],NSFontAttributeName,
                                          aParagraphStyle, NSParagraphStyleAttributeName,
                                          nil] autorelease];
  
		
	NSString *aName = [data name];
	NSSize aNameSize = [aName sizeWithAttributes:nameAttrib];
	
	NSString *aEmail = [data email];
	NSSize aEmailSize = [aEmail sizeWithAttributes:emailAttrib];
  
	NSString *aUid = [data uid];
	NSSize aUidSize = [aUid sizeWithAttributes:miniTextAttrib];
  
	NSString *aTitle = [data title];
	NSSize aTitleSize = [aTitle sizeWithAttributes:miniTextAttrib];
  
	NSString *aPhone = [NSString stringWithFormat:@"( tel. %@ )", [data telephone]];
	NSSize aPhoneSize = [aPhone sizeWithAttributes:miniTextAttrib];
  
	NSString *aStaffid = [NSString stringWithFormat:@"( id. %@ )", [data staffid]];
	NSSize aStaffidSize = [aStaffid sizeWithAttributes:miniTextAttrib];
  
	// Horizontal padding between icon and text
	float		aHorizontalPadding = 10.0;
	
	// Icon box: center the icon vertically inside of the inset rect
	NSRect anIconBox = NSMakeRect(anInsetRect.origin.x,
                                anInsetRect.origin.y + anInsetRect.size.height*.5 - anIconSize.height*.5,
                                anIconSize.width,
                                anIconSize.height);
	
	// Make a box for our text
	float aCombinedHeight = aNameSize.height + aEmailSize.height + aUidSize.height;
	
	NSRect aTextBox = NSMakeRect(anIconBox.origin.x + aHorizontalPadding,
                              anInsetRect.origin.y + anInsetRect.size.height*.5 - aCombinedHeight*.5 - 5.0,
                              anInsetRect.size.width - anIconSize.width - aHorizontalPadding,
                              aCombinedHeight);
	
	// Now split the text box in half and put the title box in the top half and subtitle box in bottom half
	NSRect aNameBox = NSMakeRect(aTextBox.origin.x, 
                              aTextBox.origin.y + aTextBox.size.height*.5 - aNameSize.height - 2.0,
                              aNameSize.width,
                              aNameSize.height);
  
  NSRect aUidBox = NSMakeRect(aTextBox.origin.x + aNameBox.size.width + 5.0,
                              aTextBox.origin.y + aTextBox.size.height*.5 - aNameBox.size.height + 3.5,
                              aUidSize.width,
                              aUidSize.height);
  
	NSRect aTitleBox = NSMakeRect(aTextBox.origin.x,
                              aTextBox.origin.y + aTextBox.size.height*.5 + aUidSize.height + 2.0,
                              aTitleSize.width,
                              aTitleSize.height);
  
  NSRect aPhoneBox = NSMakeRect(aTextBox.origin.x + aEmailSize.width + 5.0,
                                aTextBox.origin.y + aTextBox.size.height*.5,
                                aPhoneSize.width,
                                aPhoneSize.height);
  
	NSRect aEmailBox = NSMakeRect(aTextBox.origin.x,
                              aTextBox.origin.y + aTextBox.size.height*.5,
                              aTextBox.size.width,
                              aEmailSize.height);
	
  NSRect aStaffidBox = NSMakeRect(aTextBox.origin.x + aTitleSize.width + 5.0,
                              aTextBox.origin.y + aTextBox.size.height*.5 + aUidSize.height + 2.0,
                              aStaffidSize.width,
                              aStaffidSize.height);
	
	if(	[self isHighlighted])
	{
		// if the cell is highlighted, draw the text white
		[nameAttrib setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[emailAttrib setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[miniTextAttrib setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
		[miniText1Attrib setValue:[NSColor whiteColor] forKey:NSForegroundColorAttributeName];
	}
	else
	{
		// if the cell is not highlighted, draw the title black and the subtile gray
		[nameAttrib setValue:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
		[emailAttrib setValue:[NSColor blackColor] forKey:NSForegroundColorAttributeName];
		[miniTextAttrib setValue:[NSColor darkGrayColor] forKey:NSForegroundColorAttributeName];
		[miniText1Attrib setValue:[NSColor darkGrayColor] forKey:NSForegroundColorAttributeName];
	}
	
	// Draw the icon
	//[anIcon drawInRect:anIconBox fromRect:NSZeroRect operation:NSCompositeSourceOver fraction:1.0];
	
	// Draw the text
	[aName drawInRect:aNameBox withAttributes:nameAttrib];
	[aEmail drawInRect:aEmailBox withAttributes:emailAttrib];
	[aTitle drawInRect:aTitleBox withAttributes:miniTextAttrib];
	[aUid drawInRect:aUidBox withAttributes:miniText1Attrib];
  if ([data telephone])
    [aPhone drawInRect:aPhoneBox withAttributes:miniText1Attrib];
  if ([data staffid])
    [aStaffid drawInRect:aStaffidBox withAttributes:miniText1Attrib];
}

@end
