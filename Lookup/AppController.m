//
//  AppController.m
//  abFinder
//
//  Created by Duncan Robertson on 15/12/2008.
//  Copyright 2008 Whomwah. All rights reserved.
//

#import "AppController.h"
#import "PreferencesWindowController.h"
#import "MyController.h"

@implementation AppController

+ (void)initialize
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
  NSBundle *myb = [NSBundle mainBundle];
  
  [defaultValues setObject:[myb objectForInfoDictionaryKey:@"DSRLdapServer"] forKey:DSRLdapServer];
  [defaultValues setObject:[myb objectForInfoDictionaryKey:@"DSRBaseSearch"] forKey:DSRBaseSearch];
  [defaultValues setObject:[myb objectForInfoDictionaryKey:@"DSRMaxResults"] forKey:DSRMaxResults];
  [defaultValues setObject:[myb objectForInfoDictionaryKey:@"DRSSearchString"] forKey:DRSSearchString];
  [defaults registerDefaults:defaultValues];
}

- (void)displayPreferenceWindow:(id)sender
{
	if (!preferencesWindowController) {
    preferencesWindowController = [[PreferencesWindowController alloc] init];
	}
	[preferencesWindowController showWindow:self];
}

- (IBAction)whatIsLdap:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://en.wikipedia.org/wiki/LDAP"];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)ldapSearchHomepage:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://docs.sun.com/source/816-6400-10/lsearch.html"];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

- (IBAction)visitWhomwah:(id)sender
{
  NSURL *url = [NSURL URLWithString:@"http://whomwah.com/"];
  [[NSWorkspace sharedWorkspace] openURL:url];
}

@end
