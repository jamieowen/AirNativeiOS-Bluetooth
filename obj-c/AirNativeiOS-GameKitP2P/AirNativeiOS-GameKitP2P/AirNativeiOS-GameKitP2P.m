//
//  AirNativeiOS-GameKitP2P.m
//  AirNativeiOS-GameKitP2P
//
//  Created by Jamie Owen on 05/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import <GameKit/GameKit.h>
#import "AirNativeiOS-GKImpl.h"

AirNativeiOS_GKImpl* gkImpl;

///////////////////////////////////////////////////////////////
////////////// GKPeer2Peer

FREObject gkp2p_createGKSession(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    //currentSession = nil;
    return NULL;
    
}

FREObject gkp2p_createGKPeerPickerController(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    return NULL;
}

///////////////////////////////////////////////////////////////
////////////// GKSession

FREObject gkSession_get_available(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, Boolean
    return NULL;
}

FREObject gkSession_set_available(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    
    //, available:Boolean
    return NULL;
}

FREObject gkSession_get_displayName(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, String
    return NULL;
}

FREObject gkSession_get_peerID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, String
    return NULL;
}

FREObject gkSession_get_sessionID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, String
    return NULL;
}

FREObject gkSession_get_sessionMode(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, String
    return NULL;
}

FREObject gkSession_get_disconnectTimeout(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, uint
    return NULL;
}

FREObject gkSession_set_disconnectTimeout(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, timeout:uint    
    return NULL;
}


FREObject gkSession_initWithSessionID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //    , displayName:String, sessionMode:uint
    return NULL;
}

FREObject gkSession_peersWithConnectionState(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //returns Vector<String>
    return NULL;
}

FREObject gkSession_displayNameForPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //peerId:String, returns String
    return NULL;
}

FREObject gkSession_connectToPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, peerId:String, timeOut:uint
    return NULL;
}

FREObject gkSession_cancelConnectToPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //, peerId:String, 
    return NULL;
}

FREObject gkSession_acceptConnectionFromPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //peerId:String, returns Boolean
    return NULL;
}


FREObject gkSession_denyConnectionFromPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //peerId:String
    return NULL;
}

FREObject gkSession_sendData(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //data:String, peers:Vector<String>, dataMode:uint, returns Boolean
    return NULL;
}

FREObject gkSession_sendDataToAllPeers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //data:String, dataMode:uint, returns Boolean
    return NULL;
}


FREObject gkSession_disconnectFromAllPeers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject gkSession_disconnectPeerFromAllPeers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //peerID:String
    return NULL;
}


FREObject gkSession_getLastNSError(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //Object{message:"",code:""}
    return NULL;
}

FREObject gkSession_dispose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}


///////////////////////////////////////////////////////////////
////////////// GKSessionDelegate

//AS3 event types - as defined in GKSessionEvent
//gkSessionConnectionWithPeerFailed
//gkSessionDidFailWithError
//gkSessionChangeState
//gkSessionDidReceiveConnectionRequestFromPeer
//gkSessionDataReceived

///////////////////////////////////////////////////////////////
////////////// GKPeerPickerController

FREObject gkPeerPickerController_show(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject gkPeerPickerController_dismiss(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject gkPeerPickerController_get_connectionTypesMask(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    //returns uint
    return NULL;
}

FREObject gkPeerPickerController_set_connectionTypesMask(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject gkPeerPickerController_get_visible(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}

FREObject gkPeerPickerController_dispose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    return NULL;
}


///////////////////////////////////////////////////////////////
////////////// GKPeerPickerControllerDelegate

//AS3 event types - as defined in GKPeerPickerControllerDelegate
//gkPeerPickerDidConnectPeer
//gkPeerPickerControllerDidCancel

///////////////////////////////////////////////////////////////
////////////// AirNative Required Initializers
//
// ContextInitializer()
//
// The context initializer is called when the runtime creates the extension context instance.
void ContextInitializer(void* extData, const uint8_t* ctxType, 
                               FREContext ctx,
                               uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet )
{
    *numFunctionsToTest = 29;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction)*29);
    
    //////////////////
    // GKPeer2Peer (as)
    
    func[0].name         = (const uint8_t*) "gkp2p_createGKPeerPickerController";
    func[0].functionData = NULL;
    func[0].function     = &gkp2p_createGKSession;
    
    func[1].name         = (const uint8_t*) "gkp2p_createGKPeerPickerController";
    func[1].functionData = NULL;
    func[1].function     = &gkp2p_createGKPeerPickerController;
    
    //////////////////
    // GKSession
    
    func[2].name         = (const uint8_t*) "gkSession_get_available";
    func[2].functionData = NULL;
    func[2].function     = &gkSession_get_available;
    
    func[3].name         = (const uint8_t*) "gkSession_set_available";
    func[3].functionData = NULL;
    func[3].function     = &gkSession_set_available;
    
    func[4].name         = (const uint8_t*) "gkSession_get_displayName";
    func[4].functionData = NULL;
    func[4].function     = &gkSession_get_displayName;
    
    func[5].name         = (const uint8_t*) "gkSession_get_peerID";
    func[5].functionData = NULL;
    func[5].function     = &gkSession_get_peerID;
    
    func[6].name         = (const uint8_t*) "gkSession_get_sessionID";
    func[6].functionData = NULL;
    func[6].function     = &gkSession_get_sessionID;
    
    func[7].name         = (const uint8_t*) "gkSession_get_sessionMode";
    func[7].functionData = NULL;
    func[7].function     = &gkSession_get_sessionMode;
    
    func[8].name         = (const uint8_t*) "gkSession_get_disconnectTimeout";
    func[8].functionData = NULL;
    func[8].function     = &gkSession_get_disconnectTimeout;
    
    func[9].name         = (const uint8_t*) "gkSession_set_disconnectTimeout";
    func[9].functionData = NULL;
    func[9].function     = &gkSession_set_disconnectTimeout;
    
    func[10].name         = (const uint8_t*) "gkSession_initWithSessionID";
    func[10].functionData  = NULL;
    func[10].function     = &gkSession_initWithSessionID;
    
    func[11].name         = (const uint8_t*) "gkSession_peersWithConnectionState";
    func[11].functionData  = NULL;
    func[11].function     = &gkSession_peersWithConnectionState;
    
    func[12].name         = (const uint8_t*) "gkSession_displayNameForPeer";
    func[12].functionData  = NULL;
    func[12].function     = &gkSession_displayNameForPeer;
    
    func[13].name         = (const uint8_t*) "gkSession_connectToPeer";
    func[13].functionData  = NULL;
    func[13].function     = &gkSession_connectToPeer;
    
    func[14].name         = (const uint8_t*) "gkSession_cancelConnectToPeer";
    func[14].functionData  = NULL;
    func[14].function     = &gkSession_cancelConnectToPeer;
    
    func[15].name         = (const uint8_t*) "gkSession_acceptConnectionFromPeer";
    func[15].functionData  = NULL;
    func[15].function     = &gkSession_acceptConnectionFromPeer;
    
    func[16].name         = (const uint8_t*) "gkSession_denyConnectionFromPeer";
    func[16].functionData = NULL;
    func[16].function     = &gkSession_denyConnectionFromPeer;
    
    func[17].name         = (const uint8_t*) "gkSession_sendData";
    func[17].functionData = NULL;
    func[17].function     = &gkSession_sendData;
    
    func[18].name         = (const uint8_t*) "gkSession_sendDataToAllPeers";
    func[18].functionData = NULL;
    func[18].function     = &gkSession_sendDataToAllPeers;
    
    func[19].name         = (const uint8_t*) "gkSession_disconnectFromAllPeers";
    func[19].functionData = NULL;
    func[19].function     = &gkSession_disconnectFromAllPeers;
    
    func[20].name         = (const uint8_t*) "gkSession_disconnectPeerFromAllPeers";
    func[20].functionData = NULL;
    func[20].function     = &gkSession_disconnectPeerFromAllPeers;
    
    func[21].name         = (const uint8_t*) "gkSession_getLastNSError";
    func[21].functionData = NULL;
    func[21].function     = &gkSession_getLastNSError;
    
    func[22].name         = (const uint8_t*) "gkSession_dispose";
    func[22].functionData = NULL;
    func[22].function     = &gkSession_dispose;
    
    func[23].name         = (const uint8_t*) "gkPeerPickerController_show";
    func[23].functionData = NULL;
    func[23].function     = &gkPeerPickerController_show;
    
    func[24].name         = (const uint8_t*) "gkPeerPickerController_dismiss";
    func[24].functionData = NULL;
    func[24].function     = &gkPeerPickerController_dismiss;
    
    func[25].name         = (const uint8_t*) "gkPeerPickerController_get_connectionTypesMask";
    func[25].functionData = NULL;
    func[25].function     = &gkPeerPickerController_get_connectionTypesMask;
    
    func[26].name         = (const uint8_t*) "gkPeerPickerController_set_connectionTypesMask";
    func[26].functionData = NULL;
    func[26].function     = &gkPeerPickerController_set_connectionTypesMask;
    
    func[27].name         = (const uint8_t*) "gkPeerPickerController_get_visible";
    func[27].functionData = NULL;
    func[27].function     = &gkPeerPickerController_get_visible;
    
    func[28].name         = (const uint8_t*) "gkPeerPickerController_dispose";
    func[28].functionData = NULL;
    func[28].function     = &gkPeerPickerController_dispose;
    
    *functionsToSet = func;
}

// ContextFinalizer()
//
// The context finalizer is called when the extension's ActionScript code
// calls the ExtensionContext instance's dispose() method.
// If the AIR runtime garbage collector disposes of the ExtensionContext instance, the runtime also calls
// ContextFinalizer().

void ContextFinalizer(FREContext ctx) {
    
    NSLog(@"Entering ContextFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ContextFinalizer()");
    
	return;
}

// ExtInitializer()
//
// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void ExtInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, 
                           FREContextFinalizer* ctxFinalizerToSet) {
    
    NSLog(@"Entering ExtInitializer()");
    
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
    
    NSLog(@"Exiting ExtInitializer()");
}

// ExtFinalizer()
//
// The extension finalizer is called when the runtime unloads the extension. However, it is not always called.
void ExtFinalizer(void* extData) {
    
    NSLog(@"Entering ExtFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ExtFinalizer()");
    return;
}




