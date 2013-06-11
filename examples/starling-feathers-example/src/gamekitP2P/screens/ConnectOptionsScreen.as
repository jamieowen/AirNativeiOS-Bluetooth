package gamekitP2P.screens {
	import feathers.controls.ScreenNavigator;
	import feathers.events.FeathersEventType;
	import gamekitP2P.data.P2PData;
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.Label;
	import feathers.controls.PanelScreen;
	import feathers.layout.VerticalLayout;

	import gamekitP2P.Main;

	import starling.events.Event;

	/**
	 * @author jamieowen
	 */
	public class ConnectOptionsScreen extends PanelScreen
	{
		public var hostLabel:Label;
		public var clientConnectLabel:Label;
		public var peerPickerLabel:Label;
		
		public var hostButton:Button;
		public var clientConnectButton:Button;
		public var peerPickerButton:Button;
		
		public var data:P2PData;
		
		public function ConnectOptionsScreen()
		{
			super();
		}
		
		
		override protected function initialize():void
		{
			super.initialize();
			
			const layout:VerticalLayout = new VerticalLayout();
			layout.horizontalAlign = VerticalLayout.HORIZONTAL_ALIGN_CENTER;
			layout.gap = 10;
			
			this.layout = layout;
			
			this.headerFactory = function():Header
			{
				var header:Header = new Header();
				header.title = "Connect Options";
				return header;	
			};
			
			hostLabel = new Label();
			hostLabel.text = "Starts a new session as the host.";
			addChild( hostLabel );
			
			hostButton = new Button();
			hostButton.label = "Host a GKSession";
			addChild( hostButton );
			
			clientConnectLabel = new Label();
			clientConnectLabel.text = "Connects to a hosted session.";
			addChild( clientConnectLabel );
			
			clientConnectButton = new Button();
			clientConnectButton.label = "Connect to a GKSession";
			addChild( clientConnectButton );
			
			peerPickerLabel = new Label();
			peerPickerLabel.text = "Uses the native iOS PeerPicker.";
			addChild( peerPickerLabel );
			
			peerPickerButton = new Button();
			peerPickerButton.label = "Peer Picker Connect.";
			addChild( peerPickerButton );
			
			hostButton.addEventListener( Event.TRIGGERED, onButtonTriggered );
			clientConnectButton.addEventListener( Event.TRIGGERED, onButtonTriggered );
			peerPickerButton.addEventListener( Event.TRIGGERED, onButtonTriggered );
			
			owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, onTransitionComplete );
		}
		
		private function onTransitionComplete(ev:Event):void
		{
			if( (ev.target as ScreenNavigator ).activeScreen == this )
			{
				this.data.connectionType = P2PData.CONNECTION_TYPE_UNDEFINED;				
			}
		
		}
		
		private function onButtonTriggered(event:Event):void
		{
			switch( event.target )
			{
				case hostButton:
					this.data.connectionType = P2PData.CONNECTION_TYPE_HOST;
					owner.showScreen( Main.HOST_CONNECTION_SCREEN );
					break;
				case clientConnectButton:
					this.data.connectionType = P2PData.CONNECTION_TYPE_CLIENT;
					owner.showScreen( Main.CLIENT_CONNECTION_SCREEN );
					break;
				case peerPickerButton:
					this.data.connectionType = P2PData.CONNECTION_TYPE_PEERPICKER;
					owner.showScreen( Main.PEERPICKER_WAIT_SCREEN );
					
					break;
			}
		}
	}
}
