//
//  AppController.h
//  abFinder
//
//  Created by Duncan Robertson on 15/12/2008.
//  Copyright 2008 Whomwah. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class PreferencesWindowController;

@interface AppController : NSObject {
  PreferencesWindowController *preferencesWindowController;
}

- (IBAction)displayPreferenceWindow:(id)sender;
- (IBAction)whatIsLdap:(id)sender;
- (IBAction)ldapSearchHomepage:(id)sender;
- (IBAction)visitWhomwah:(id)sender;

@end
