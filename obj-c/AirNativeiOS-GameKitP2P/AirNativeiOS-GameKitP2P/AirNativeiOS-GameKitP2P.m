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

/**FREObject gkp2p_createGKSession(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    [ gkImpl createSession ];
    return NULL;
}**/

FREObject gkp2p_createGKPeerPickerController(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[] )
{
    [ gkImpl createPicker ];
    return NULL;
}


///////////////////////////////////////////////////////////////
////////////// GKSession

FREObject gkSession_get_available(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return Boolean
    
    uint32_t available = gkImpl.currentSession.available == true ? 1 : 0;
    FREObject result = nil;
    FRENewObjectFromBool(available, &result);
    return result;
}

FREObject gkSession_set_available(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params available:Boolean
    // @return null
    
    uint32_t available = 0;
    FREGetObjectAsBool( argv[0], &available );
    
    gkImpl.currentSession.available = available == 1 ? true : false;
    return NULL;
}

FREObject gkSession_get_displayName(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return String
    
    NSString* str = gkImpl.currentSession.displayName;
    const char *chars = [str UTF8String];
    FREObject result;
    FRENewObjectFromUTF8( strlen(chars)+1, (const uint8_t*)chars, &result);
    
    return result;
}

FREObject gkSession_get_peerID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return String
    
    NSString* str = gkImpl.currentSession.peerID;
    const char *chars = [str UTF8String];
    FREObject result;
    FRENewObjectFromUTF8( strlen(chars)+1, (const uint8_t*)chars, &result);
    
    return result;
}

FREObject gkSession_get_sessionID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @return String
    
    NSString* str = gkImpl.currentSession.sessionID;
    const char *chars = [str UTF8String];
    FREObject result;
    FRENewObjectFromUTF8( strlen(chars)+1, (const uint8_t*)chars, &result);
    
    return result;
}

FREObject gkSession_get_sessionMode(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return uint
    
    uint32_t mode;
    
    switch( gkImpl.currentSession.sessionMode )
    {
        case GKSessionModeServer :
            mode = 0;
            break;
        case GKSessionModeClient :
            mode = 1;
            break;
        case GKSessionModePeer :
            mode = 2;
            break;
    }
    
    FREObject result;
    FRENewObjectFromUint32(mode, &result);
    
    return result;
}

FREObject gkSession_get_disconnectTimeout(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return Number
    
    double interval = gkImpl.currentSession.disconnectTimeout;
    FREObject result;
    FRENewObjectFromDouble( interval, &result );
    
    return result;
}

FREObject gkSession_set_disconnectTimeout(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params timeout:Number
    // @return null
    
    double interval;
    FREGetObjectAsDouble(argv[0], &interval);
    gkImpl.currentSession.disconnectTimeout = interval;
    return NULL;
}

/**
FREObject gkSession_initWithSessionID(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params sessionId:String, displayName:String, sessionMode:uint
    // @return null
    
    uint32_t sessionIDLen;
    const uint8_t *sessionIDChars;   
    FREGetObjectAsUTF8(argv[0], &sessionIDLen, &sessionIDChars );
    
    uint32_t nameLen;
    const uint8_t *name;   
    FREGetObjectAsUTF8(argv[1], &nameLen, &name );
    
    NSString *sessionID = [NSString stringWithUTF8String:(char*)sessionIDChars];
    NSString *displayName = [NSString stringWithUTF8String:(char*)name];
    
    uint32_t sessionMode;
    FREGetObjectAsUint32(argv[2], &sessionMode);
    
    // Actionscript consts:
    // public static const SERVER:uint 		= 0;
    // public static const CLIENT:uint 		= 1;
    // public static const PEER:uint 		= 2;    
     
    switch( sessionMode )
    {
        case 0 :
            [ gkImpl.currentSession initWithSessionID:sessionID displayName:displayName sessionMode:GKSessionModeServer ];
            break;
        case 1 :
            [ gkImpl.currentSession initWithSessionID:sessionID displayName:displayName sessionMode:GKSessionModeClient ];
            break;
        case 2 :
            [ gkImpl.currentSession initWithSessionID:sessionID displayName:displayName sessionMode:GKSessionModePeer ];
            break;
    }
    
    return NULL;
}
**/

FREObject gkSession_peersWithConnectionState(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params state:uint
    // @return Vector.<String>
    
    uint32_t state;
    FREGetObjectAsUint32( argv[0], &state );
    
    // Actionscript GKPeerConnectionState values:
    // public static const AVAILABLE:uint 	 = 0;
    // public static const CONNECTED:uint 	 = 1;
    // public static const CONNECTING:uint 	 = 2;
    // public static const DISCONNECTED:uint = 3;
    // public static const UNAVAILABLE:uint	 = 4;
    
    NSArray *peers = NULL;
    
    switch( state )
    {
        case 0 :
            peers = [ gkImpl.currentSession peersWithConnectionState:GKPeerStateAvailable ];
            break;
        case 1 :
            peers = [ gkImpl.currentSession peersWithConnectionState:GKPeerStateConnected ];
            break;
        case 2 :
            peers = [ gkImpl.currentSession peersWithConnectionState:GKPeerStateConnecting ];
            break;
        case 3 :
            peers = [ gkImpl.currentSession peersWithConnectionState:GKPeerStateDisconnected ];
            break;
        case 4 :
            peers = [ gkImpl.currentSession peersWithConnectionState:GKPeerStateUnavailable ];
            break;
    }
    
    // convert to Actionscript Vector.<String>
    
    
    
    
    FREObject resultVector;
    FRENewObject((const uint8_t*)"Vector.<String>", 0, NULL, &resultVector, nil);
    FRESetArrayLength( resultVector, peers.count );

    NSString *peerID = NULL;
    
    for( NSUInteger i = 0; i<peers.count; i++ )
    {
        FREObject peerIDResult;
        peerID = [ peers objectAtIndex:i ];
        
        FRENewObjectFromUTF8(peerID.length, (const uint8_t*)peerID.UTF8String, &peerIDResult );
        
        FRESetArrayElementAt(resultVector, i, peerIDResult);
    }
    
    return resultVector;
}


FREObject gkSession_displayNameForPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    uint32_t peerIDLength;
    const uint8_t *peerIDFromAs;
    FREGetObjectAsUTF8(argv[0], &peerIDLength, &peerIDFromAs );
    
    NSString *peerID = [NSString stringWithUTF8String:(char*)peerIDFromAs];
    
    NSString *displayName = [ gkImpl.currentSession displayNameForPeer:peerID ];

    const char *displayNameAsChar = [displayName UTF8String];
    FREObject displayNameResult;
    FRENewObjectFromUTF8( strlen(displayNameAsChar)+1, (const uint8_t*)displayNameAsChar, &displayNameResult);
    
    return displayNameResult;
}

/**

FREObject gkSession_connectToPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params peerID:String
    // @return null
    
    uint32_t peerIDLen;
    const uint8_t *peerIDChars;   
    FREGetObjectAsUTF8(argv[0], &peerIDLen, &peerIDChars );
    NSString *peerID = [NSString stringWithUTF8String:(char*)peerIDChars];
    
    double interval;
    FREGetObjectAsDouble(argv[1], &interval);
    gkImpl.currentSession.disconnectTimeout = interval;
    
    [ gkImpl.currentSession connectToPeer:peerID withTimeout:interval ];
    
    return NULL;
}

FREObject gkSession_cancelConnectToPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params peerID:String
    // @return null
    
    uint32_t peerIDLen;
    const uint8_t *peerIDChars;   
    FREGetObjectAsUTF8(argv[0], &peerIDLen, &peerIDChars );
    NSString *peerID = [NSString stringWithUTF8String:(char*)peerIDChars];
    
    [ gkImpl.currentSession cancelConnectToPeer:peerID ];
    
    return NULL;
}

FREObject gkSession_acceptConnectionFromPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params peerID:String
    // @return Boolean
    
    uint32_t peerIDLen;
    const uint8_t *peerIDChars;   
    FREGetObjectAsUTF8(argv[0], &peerIDLen, &peerIDChars );
    NSString *peerID = [NSString stringWithUTF8String:(char*)peerIDChars];
    
    // ******
    // TODO : Need to handle error here
    BOOL success= [ gkImpl.currentSession acceptConnectionFromPeer:peerID error:nil ];
    
    uint32_t successInt = success == true ? 1 : 0;
    FREObject result;
    FRENewObjectFromBool( successInt, &result);
    
    return result;
}


FREObject gkSession_denyConnectionFromPeer(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params peerID:String
    // @return null
    
    uint32_t peerIDLen;
    const uint8_t *peerIDChars;   
    FREGetObjectAsUTF8(argv[0], &peerIDLen, &peerIDChars );
    NSString *peerID = [NSString stringWithUTF8String:(char*)peerIDChars];
    
    [ gkImpl.currentSession denyConnectionFromPeer:peerID ];
    return NULL;
}

FREObject gkSession_sendData(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params data:String, peers:Vector<String>, dataMode:uint
    // @return Boolean
    
    uint32_t dataLen;
    const uint8_t *dataChars;   
    FREGetObjectAsUTF8(argv[0], &dataLen, &dataChars );
    
    NSString *data = [NSString stringWithUTF8String:(char*)dataChars];
    
    uint32_t dataMode;
    FREGetObjectAsUint32(argv[2], &dataMode);
    
    // get peers.
    uint32_t peersLen;
    FREObject peersVector = argv[1];
    FREGetArrayLength(peersVector, &peersLen);
    
    NSMutableArray* peers = [[NSMutableArray alloc] init ];

    for( uint32_t i = 0; i<peersLen; i++ )
    {
        uint32_t peerLen;
        const uint8_t *peerChars;
        
        FREObject peer;
        FREGetArrayElementAt( peersVector, i, &peer );
        FREGetObjectAsUTF8( peer, &peerLen, &peerChars);
        
        [ peers addObject:[NSString stringWithUTF8String:(char*)peerChars] ];
    }
    
    // ******
    // TODO : Need to handle error here
    BOOL sendResult;
    switch( dataMode )
    {
        case 0 :
            sendResult = [ gkImpl.currentSession sendData:[ data dataUsingEncoding:NSUTF8StringEncoding ] toPeers:peers withDataMode:GKSendDataReliable error:nil ];
            break;
        case 1 :
            sendResult = [ gkImpl.currentSession sendData:[ data dataUsingEncoding:NSUTF8StringEncoding ] toPeers:peers withDataMode:GKSendDataUnreliable error:nil ];
            break;
    }
    
    FREObject result;
    uint32_t resultInt = sendResult == true ? 1 : 0;
    FRENewObjectFromBool(resultInt, &result);
    return result;
}
**/
FREObject gkSession_sendDataToAllPeers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params data:String, dataMode:uint
    // @return Boolean
    
    uint32_t dataLen;
    const uint8_t *dataChars;   
    FREGetObjectAsUTF8(argv[0], &dataLen, &dataChars );
    
    NSString *data = [NSString stringWithUTF8String:(char*)dataChars];
    
    uint32_t dataMode;
    FREGetObjectAsUint32(argv[1], &dataMode);

    // ******
    // TODO : Need to handle error here
    
    BOOL sendResult;
    switch( dataMode )
    {
        case 0 :
            sendResult = [ gkImpl.currentSession sendDataToAllPeers:[ data dataUsingEncoding:NSUTF8StringEncoding ] withDataMode:GKSendDataReliable error:nil ];
            break;
        case 1 :
            sendResult = [ gkImpl.currentSession sendDataToAllPeers:[ data dataUsingEncoding:NSUTF8StringEncoding ] withDataMode:GKSendDataUnreliable error:nil ];
            break;
    }

    FREObject result;
    uint32_t resultInt = sendResult == true ? 1 : 0;
    FRENewObjectFromBool(resultInt, &result);
    return result;
}


FREObject gkSession_disconnectFromAllPeers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return null
    
    [ gkImpl.currentSession disconnectFromAllPeers ];
    return NULL;
}
/**
FREObject gkSession_disconnectPeerFromAllPeers(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params peerID:String
    // @return null
    
    uint32_t peerIDLen;
    const uint8_t *peerIDChars;   
    FREGetObjectAsUTF8(argv[0], &peerIDLen, &peerIDChars );
    NSString *peerID = [NSString stringWithUTF8String:(char*)peerIDChars];
    
    [ gkImpl.currentSession disconnectPeerFromAllPeers:peerID ];
    
    return NULL;
}

**/

FREObject gkSession_dispose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isSessionOK ) return NULL;
    
    // @params null
    // @return null
    
    [ gkImpl disposeSession ];
    return NULL;
}


///////////////////////////////////////////////////////////////
////////////// GKPeerPickerController

FREObject gkPeerPickerController_show(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isPickerOK ) return NULL;
    
    // @params null
    // @return null
    
    [ gkImpl.currentPicker show ];
    return NULL;
}

FREObject gkPeerPickerController_dismiss(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isPickerOK ) return NULL;
    
    // @params null
    // @return null
    
    [ gkImpl.currentPicker dismiss ];
    return NULL;
}

//FREObject gkPeerPickerController_get_connectionTypesMask(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
//{
    //returns uint
//    return NULL;
//}

//FREObject gkPeerPickerController_set_connectionTypesMask(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
//{
//    return NULL;
//}

FREObject gkPeerPickerController_get_visible(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isPickerOK ) return NULL;
    
    // @params null
    // @return Boolean
    
    uint32_t visible = gkImpl.currentPicker.visible == true ? 1 : 0;
    FREObject result = nil;
    FRENewObjectFromBool(visible, &result);
    return result;
}

FREObject gkPeerPickerController_dispose(FREContext ctx, void* funcData, uint32_t argc, FREObject argv[])
{
    if( !gkImpl.isPickerOK ) return NULL;
    
    // @params null
    // @return null
    
    [ gkImpl disposePicker ];
    return NULL;
}


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
    // create the gamekit delegate
    gkImpl = [[AirNativeiOS_GKImpl alloc] initWithContext:ctx];
    
    *numFunctionsToTest = 18;//26;
    
    FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction)*18);
    
    //////////////////
    // GKPeer2Peer (as)
    
    /**func[0].name         = (const uint8_t*) "gkp2p_createGKPeerPickerController";
    func[0].functionData = NULL;
    func[0].function     = &gkp2p_createGKSession;**/
    
    func[0].name         = (const uint8_t*) "gkp2p_createGKPeerPickerController";
    func[0].functionData = NULL;
    func[0].function     = &gkp2p_createGKPeerPickerController;
    
    //////////////////
    // GKSession
    
    func[1].name         = (const uint8_t*) "gkSession_get_available";
    func[1].functionData = NULL;
    func[1].function     = &gkSession_get_available;
    
    func[2].name         = (const uint8_t*) "gkSession_set_available";
    func[2].functionData = NULL;
    func[2].function     = &gkSession_set_available;
    
    func[3].name         = (const uint8_t*) "gkSession_get_displayName";
    func[3].functionData = NULL;
    func[3].function     = &gkSession_get_displayName;
    
    func[4].name         = (const uint8_t*) "gkSession_get_peerID";
    func[4].functionData = NULL;
    func[4].function     = &gkSession_get_peerID;
    
    func[5].name         = (const uint8_t*) "gkSession_get_sessionID";
    func[5].functionData = NULL;
    func[5].function     = &gkSession_get_sessionID;
    
    func[6].name         = (const uint8_t*) "gkSession_get_sessionMode";
    func[6].functionData = NULL;
    func[6].function     = &gkSession_get_sessionMode;
    
    func[7].name         = (const uint8_t*) "gkSession_get_disconnectTimeout";
    func[7].functionData = NULL;
    func[7].function     = &gkSession_get_disconnectTimeout;
    
    func[8].name         = (const uint8_t*) "gkSession_set_disconnectTimeout";
    func[8].functionData = NULL;
    func[8].function     = &gkSession_set_disconnectTimeout;
    /**
    func[10].name         = (const uint8_t*) "gkSession_initWithSessionID";
    func[10].functionData  = NULL;
    func[10].function     = &gkSession_initWithSessionID;
    **/
    func[9].name         = (const uint8_t*) "gkSession_peersWithConnectionState";
    func[9].functionData  = NULL;
    func[9].function     = &gkSession_peersWithConnectionState;

    func[10].name         = (const uint8_t*) "gkSession_displayNameForPeer";
    func[10].functionData  = NULL;
    func[10].function     = &gkSession_displayNameForPeer;
    /**
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
    **/
    func[11].name         = (const uint8_t*) "gkSession_sendDataToAllPeers";
    func[11].functionData = NULL;
    func[11].function     = &gkSession_sendDataToAllPeers;
   
    func[12].name         = (const uint8_t*) "gkSession_disconnectFromAllPeers";
    func[12].functionData = NULL;
    func[12].function     = &gkSession_disconnectFromAllPeers;
    /**
    func[20].name         = (const uint8_t*) "gkSession_disconnectPeerFromAllPeers";
    func[20].functionData = NULL;
    func[20].function     = &gkSession_disconnectPeerFromAllPeers;
    **/
    func[13].name         = (const uint8_t*) "gkSession_dispose";
    func[13].functionData = NULL;
    func[13].function     = &gkSession_dispose;
    
    func[14].name         = (const uint8_t*) "gkPeerPickerController_show";
    func[14].functionData = NULL;
    func[14].function     = &gkPeerPickerController_show;
    
    func[15].name         = (const uint8_t*) "gkPeerPickerController_dismiss";
    func[15].functionData = NULL;
    func[15].function     = &gkPeerPickerController_dismiss;
    
    //func[25].name         = (const uint8_t*) "gkPeerPickerController_get_connectionTypesMask";
    //func[25].functionData = NULL;
    //func[25].function     = &gkPeerPickerController_get_connectionTypesMask;
    
    //func[26].name         = (const uint8_t*) "gkPeerPickerController_set_connectionTypesMask";
    //func[26].functionData = NULL;
    //func[26].function     = &gkPeerPickerController_set_connectionTypesMask;
    
    func[16].name         = (const uint8_t*) "gkPeerPickerController_get_visible";
    func[16].functionData = NULL;
    func[16].function     = &gkPeerPickerController_get_visible;
    
    func[17].name         = (const uint8_t*) "gkPeerPickerController_dispose";
    func[17].functionData = NULL;
    func[17].function     = &gkPeerPickerController_dispose;
    
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
    
    // clean up GKImpl
    [ gkImpl disposePicker ];
    [ gkImpl disposeSession ];
    [ gkImpl release ];
    
    NSLog(@"Exiting ContextFinalizer()");
    
	return;
}

// ExtInitializer()
//
// The extension initializer is called the first time the ActionScript side of the extension
// calls ExtensionContext.createExtensionContext() for any context.

void GameKitP2PExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, 
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
void GameKitP2PExtensionFinalizer(void* extData) {
    
    NSLog(@"Entering ExtFinalizer()");
    
    // Nothing to clean up.
    
    NSLog(@"Exiting ExtFinalizer()");
    return;
}




