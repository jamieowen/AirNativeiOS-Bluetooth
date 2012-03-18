
AirNativeiOS-Bluetooth
----------------------

## Description

AIR Native Extension to add Bluetooth support for iOS apps.  The Actionscript API mirrors the Objective-C API found in Apple GameKit.  To get a better understanding of Bluetooth on iOS read the [Peer-to-Peer documentation](https://developer.apple.com/library/ios/#documentation/NetworkingInternet/Conceptual/GameKit_Guide/GameKitConcepts/GameKitConcepts.html) found on the Apple GameKit Programming Guide.  And also the class reference for [GKSession](https://developer.apple.com/library/ios/#documentation/GameKit/Reference/GKSession_Class/Reference/Reference.html#//apple_ref/occ/cl/GKSession) and [GKPeerPickerController](https://developer.apple.com/library/ios/#documentation/GameKit/Reference/GKPeerPickerController_Class/Reference/Reference.html#//apple_ref/occ/cl/GKPeerPickerController).

## Usage

The native extension currently supports the features of the GKPeerPickerController and relative GKSession features only. This provides enough functionality to connect with another Peer via the default iOS Bluetooth pop-up and send messages between each other. You can view a video demo of this below, and the source for the video example is in the respository.  See Improvements below for additional functionality.

A rough example looks like :

	'''as

		// instantiating a connection
		var p2p:GKPeerToPeer = new GKPeerToPeer();
		var picker:GKPeerPickerController = p2p.createGKPeerPickerController();

		// wait for these events to know we've connected..
		picker.addEventListener(GKPeerPickerControllerEvent.DID_CONNECT_PEER, onGKPeerPickerControllerEvent, false, 0, true );
		picker.addEventListener(GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL, onGKPeerPickerControllerEvent, false, 0, true );

		// the event handler for one of the above methods would contain:
		picker.removeEventListener(GKPeerPickerControllerEvent.DID_CONNECT_PEER, onGKPeerPickerControllerEvent );
		picker.removeEventListener(GKPeerPickerControllerEvent.CONTROLLER_DID_CANCEL, onGKPeerPickerControllerEvent );

		picker.dismiss(); // hides the iOS popup after connection.
		picker.dispose(); // remember to dispose!!

		// access the new GKSession object now we've connected.

		var session:GKSession = p2p.session;

		// then send a message
		session.sendDataToAllPeers( "Hello!", GKSendDataMode.RELIABLE );

		// after use, disconnect and dispose
		session.disconnectFromAllPeers();
		session.dispose();

	'''

## Video

Demo showing features of GKPeerPickerController basics..
http://www.youtube.com/watch?v=Tdh0DBYAtOo

## Improvements 

The full features of the GKSession object are implemented in Actionscript and C/Objective-C side but are commented out at the moment until I get a chance to test properly (testing bluetooth takes longer than usual!).  Please feel free to fork this repository and uncomment the code.  Let me know if you test and finish it! The additional features would enable :

* Establishing a GKSession manually with possibilty to connect to multiple peers.
* Building a custom peer picker interface to show available peers.
* Sending data to specific peers.
* Basically anything in the GameKit Peer-to-Peer docs.






