//
//  AirNativeiOS-AirStatusEventCodes.h
//  AirNativeiOS-GameKitP2P
//
//  Created by Jamie Owen on 06/03/2012.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#ifndef AirNativeiOS_GameKitP2P_AirNativeiOS_AirStatusEventCodes_h
#define AirNativeiOS_GameKitP2P_AirNativeiOS_AirStatusEventCodes_h

// GKSessionDelegate
#define airStatusEvent_gkSessionConnectionWithPeerFailed "gkSessionConnectionWithPeerFailed"
#define airStatusEvent_gkSessionDidFailWithError "gkSessionDidFailWithError"
#define airStatusEvent_gkSessionChangeState "gkSessionChangeState"
#define airStatusEvent_gkSessionDidReceiveConnectionRequestFromPeer "gkSessionDidReceiveConnectionRequestFromPeer"

// GKSession ReceiveData
#define airStatusEvent_gkSessionDataReceived "gkSessionDataReceived"

// GKPeerPickerControllerDelegate
#define airStatusEvent_gkPeerPickerDidConnectPeer "gkPeerPickerDidConnectPeer"
#define airStatusEvent_gkPeerPickerControllerDidCancel "gkPeerPickerControllerDidCancel"

#endif
