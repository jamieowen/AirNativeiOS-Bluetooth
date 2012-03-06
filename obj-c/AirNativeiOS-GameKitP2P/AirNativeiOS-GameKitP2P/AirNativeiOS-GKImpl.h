//
//  AirNativeiOS-GKImpl.h
//  AirNativeiOS-GameKitP2P
//
//  Created by Jamie Owen on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/Gamekit.h>
#import "FlashRuntimeExtensions.h"

@interface AirNativeiOS_GKImpl : NSObject <GKSessionDelegate, GKPeerPickerControllerDelegate>
{
    GKSession* currentSession;
    GKPeerPickerController* currentPicker;
    FREContext* airContext;
}

@property(retain) GKSession* currentSession;
@property(retain) GKPeerPickerController* currentPicker;
@property FREContext* airContext;

-(id) initWithContext:(FREContext)context;

-(void) createSession;
-(void) createPicker;

-(void) disposeSession;
-(void) disposePicker;

-(BOOL) isSessionOK;
-(BOOL) isPickerOK;

@end
