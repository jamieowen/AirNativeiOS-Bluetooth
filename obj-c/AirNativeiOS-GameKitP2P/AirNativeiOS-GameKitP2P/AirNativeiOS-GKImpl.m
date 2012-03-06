//
//  AirNativeiOS-GKImpl.m
//  AirNativeiOS-GameKitP2P
//
//  Created by Jamie Owen on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AirNativeiOS-GKImpl.h"

@implementation AirNativeiOS_GKImpl

@synthesize currentSession;
@synthesize currentPicker;

// creates a new picker object and releases any current session - existing pickers are dismissed/released also
// once the picker has selected a peer - the currentSession is set and the picker removed
-(void)createPicker
{
    [self disposePicker];
    [self disposeSession];
    
    currentPicker = [[GKPeerPickerController alloc] init];
    currentPicker.delegate = self;
}

// creates a new session to be used independently - ( rather than using the GKPeerPickerController )
-(void)createSession
{
    [self disposePicker];
    [self disposeSession];
    
    currentSession = [[GKSession alloc] init];
    currentSession.delegate = self;
}

// Disposes of the current picker and session
-(void)disposePicker
{
    if( self.currentPicker.visible ) 
        [self.currentPicker dismiss];
    
    if( self.currentPicker != nil ) self.currentPicker.delegate = nil;
    self.currentPicker = nil;
}

// Disposes of the current session
-(void)disposeSession
{
    [self.currentSession disconnectFromAllPeers];
    if( self.currentSession != nil ) self.currentSession.delegate = nil;
    self.currentSession = nil;
}


//-////////////////////////////////////////////////////////////
//-// GKPeerPickerControllerDelegate methods

// handles the connection by disposing of the picker and saving the current session
-(void)peerPickerController:(GKPeerPickerController *)picker 
             didConnectPeer:(NSString *)peerID 
                  toSession:(GKSession *)session
{
    self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    
    [self disposePicker];
    
    // dispatch event to AIR extension context
}

-(void)peerPickerController:(GKPeerPickerController *)picker 
    didSelectConnectionType:(GKPeerPickerConnectionType)type
{
    // do nothing here - we are not supporting this for now
}

-(void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    [self disposePicker];
    
    // dispatch event to AIR extension context
}

//-////////////////////////////////////////////////////////////
//-// GKSession receiveData method

-(void) receiveData:(NSData *)data 
           fromPeer:(NSString *)peer
          inSession:(GKSession *)session 
            context:(void *)context
{
    // dispatch event to AIR extension context.
}


//-////////////////////////////////////////////////////////////
//-// GKSessionDelgate methods


- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

-(void) dealloc
{
    
}

@end
