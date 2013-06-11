//
//  AirNativeiOS-GKImpl.m
//  AirNativeiOS-GameKitP2P
//
//  Created by Jamie Owen on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "AirNativeiOS-GKImpl.h"
#import "AirNativeiOS-AirStatusEventCodes.h"

@implementation AirNativeiOS_GKImpl

@synthesize currentSession;
@synthesize currentPicker;
@synthesize airContext;

-(id) initWithContext:(FREContext)context
{
    self = [super init];
    if( self )
    {
        airContext = context;
    }
    return self;
}

-(void) dealloc
{
    [self disposeSession];
    [self disposePicker];
    
    self.airContext = nil;
    [super dealloc];
}

-(BOOL) isSessionOK
{
    return currentSession != nil;
}

-(BOOL) isPickerOK
{
    return currentPicker != nil;
}

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

// handles the connection and stores the session
-(void)peerPickerController:(GKPeerPickerController *)picker 
             didConnectPeer:(NSString *)peerID 
                  toSession:(GKSession *)session
{
    self.currentSession = session;
    session.delegate = self;
    [session setDataReceiveHandler:self withContext:nil];
    
    // dispatch event to AIR extension context
    FREDispatchStatusEventAsync( airContext, (uint8_t*)airStatusEvent_gkPeerPickerDidConnectPeer, (uint8_t*)[peerID UTF8String] );

    // the AIR side should dispose the picker now
}

-(void)peerPickerController:(GKPeerPickerController *)picker 
    didSelectConnectionType:(GKPeerPickerConnectionType)type
{
    // do nothing here - we are not supporting this for now
}

-(void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker
{
    // dispatch event to AIR extension context
    FREDispatchStatusEventAsync( airContext, (uint8_t*)airStatusEvent_gkPeerPickerControllerDidCancel, (uint8_t*)"" );
    
    // the AIR side should dispose the picker now.
}

//-////////////////////////////////////////////////////////////
//-// GKSession receiveData method

-(void) receiveData:(NSData *)data 
           fromPeer:(NSString *)peer
          inSession:(GKSession *)session 
            context:(void *)context
{
    // combine the peerID and the data into one string. with "{&}" to seperate.
    
    NSString* dataStr = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
    NSString* message = [dataStr stringByAppendingString:@"{&}"];
    message = [message stringByAppendingString:peer];
    
    // dispatch event to AIR extension context.
    FREDispatchStatusEventAsync( airContext, (uint8_t*)airStatusEvent_gkSessionDataReceived, (uint8_t*)[message UTF8String] );
}


//-////////////////////////////////////////////////////////////
//-// GKSessionDelgate methods

-(void) session:(GKSession *)session 
           peer:(NSString *)peerID 
 didChangeState:(GKPeerConnectionState)state
{
    NSString* message = @"";
    
    /**
     Actionscript GKPeerConnectionState values:
     public static const AVAILABLE:uint 	= 0;
     public static const CONNECTED:uint 	= 1;
     public static const CONNECTING:uint 	= 2;
     public static const DISCONNECTED:uint 	= 3;
     public static const UNAVAILABLE:uint	= 4;
    **/
    // append the state to the message - with the code defined in the actionscript class GKPeerConnectionState
    switch(state)
    {
        case GKPeerStateAvailable:
            message = [message stringByAppendingString:@"0"];
            break;
        case GKPeerStateConnected:
            message = [message stringByAppendingString:@"1"];
            break;
        case GKPeerStateConnecting:
            message = [message stringByAppendingString:@"2"];
            break;
        case GKPeerStateDisconnected:
            message = [message stringByAppendingString:@"3"];
            break;
        case GKPeerStateUnavailable:
            message = [message stringByAppendingString:@"4"];
            break;
    }
    
    message = [message stringByAppendingString:@"{&}"];
    message = [message stringByAppendingString:peerID];
    
    // dispatch event to AIR extension context.]
    FREDispatchStatusEventAsync(airContext,(uint8_t*)airStatusEvent_gkSessionChangeState, (uint8_t*) [message UTF8String] );
}

-(void)session:(GKSession *)session connectionWithPeerFailed:(NSString *)peerID withError:(NSError *)error
{
    // encode error details in string.
    NSMutableString* message = [[NSMutableString alloc] initWithString:peerID];
    [ message appendString:@"{&}" ];
    [ message appendString:[NSString stringWithFormat:@"%d",error.code] ];
    [ message appendString:@"{&}" ];
    [ message appendString:error.description ];
    
    // dispatch event to AIR extension context.
    
    // DISABLED FOR NOW
    //FREDispatchStatusEventAsync(airContext,airStatusEvent_gkSessionDidReceiveConnectionRequestFromPeer, (uint8_t*) [message UTF8String] );
}

-(void)session:(GKSession *)session didReceiveConnectionRequestFromPeer:(NSString *)peerID
{
    // dispatch event to AIR extension context.

    // DISABLED FOR NOW
    //FREDispatchStatusEventAsync(airContext,airStatusEvent_gkSessionDidReceiveConnectionRequestFromPeer, (uint8_t*) [peerID UTF8String] );
}

-(void)session:(GKSession *)session didFailWithError:(NSError *)error
{
    NSMutableString* message = [[NSMutableString alloc] initWithString:[NSString stringWithFormat:@"%d",error.code]];
    [ message appendString:@"{&}" ];
    [ message appendString:error.description ];
    
    // dispatch event to AIR extension context.
    
    // DISABLED FOR NOW
    //FREDispatchStatusEventAsync(airContext,airStatusEvent_gkSessionDidReceiveConnectionRequestFromPeer, (uint8_t*) [message UTF8String] );
}

@end
