package gamekitP2P.screens {
	import feathers.data.ListCollection;
	import feathers.controls.List;
	import gamekitP2P.events.P2PDataEvent;
	import feathers.core.ToggleGroup;
	import feathers.controls.ToggleSwitch;
	import feathers.controls.TextInput;
	import feathers.controls.Label;
	import starling.events.Event;
	import gamekitP2P.data.P2PData;
	import feathers.controls.ScreenNavigator;
	import feathers.events.FeathersEventType;
	import feathers.controls.Header;
	import feathers.layout.VerticalLayout;
	import feathers.controls.PanelScreen;

	/**
	 * @author jamieowen
	 */
	public class SessionConnectedScreen extends PanelScreen
	{
		public var data:P2PData;
		
		public var connectionType:Label;
		public var sessionID:Label;
		public var displayName:Label;
		public var peerID:Label;
		
		public var messageSync:TextInput;
		public var toggle1:ToggleSwitch;
		public var toggle2:ToggleSwitch;
		public var toggle3:ToggleSwitch;
		
		public var peerIDList:List;
		public var peerNamesList:List;
		
		public function SessionConnectedScreen()
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
				header.title = "Session Connected";
				
				return header;
			};
			
			this.displayName = new Label();
			this.addChild( this.displayName );
			
			this.sessionID = new Label();
			this.addChild( this.sessionID );
			
			this.peerID = new Label();
			this.addChild( this.peerID );
			
			this.peerIDList = new List();
			this.addChild( this.peerIDList );
			
			this.peerNamesList = new List();
			this.addChild( this.peerNamesList );
			
			this.connectionType = new Label();
			this.addChild( this.connectionType );
			this.messageSync = new TextInput();
			this.addChild( this.messageSync );

			
			toggle1 = new ToggleSwitch();
			this.addChild( toggle1 );
			
			toggle2 = new ToggleSwitch();
			this.addChild( toggle2 );
			
			toggle3 = new ToggleSwitch();
			this.addChild( toggle3 );
			
			resetControls();
			
			this.messageSync.addEventListener(Event.CHANGE, onMessageChanged );
			
			this.toggle1.addEventListener(Event.CHANGE, onToggleTriggered );
			this.toggle2.addEventListener(Event.CHANGE, onToggleTriggered );
			this.toggle3.addEventListener(Event.CHANGE, onToggleTriggered );

			owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, onTransitionComplete );	
		}
		
		private function resetControls():void
		{
			this.connectionType.text = P2PData.CONNECTION_TYPE_UNDEFINED;
			this.messageSync.text = "Change Message...";
			this.toggle1.isSelected = this.toggle2.isSelected = this.toggle3.isSelected = false;
			this.displayName.text = "Display Name";
			this.sessionID.text = "undefined";
			this.peerID.text = "undefined";
			
			
			this.data.setKeyValue("t1",false);
			this.data.setKeyValue("t2",false);
			this.data.setKeyValue("t3",false);
			this.data.setKeyValue("m",this.messageSync.text);
		}
		
		private function onMessageChanged(event:Event):void
		{
			data.setKeyValue("m", (event.target as TextInput ).text );
		}
		
		private function onToggleTriggered( event:Event ):void
		{
			switch( event.target )
			{
				case this.toggle1:
					data.setKeyValue("t1", (event.target as ToggleSwitch ).isSelected );
					break;
				
				case this.toggle2:
					data.setKeyValue("t2", (event.target as ToggleSwitch ).isSelected );
					break;
					
				case this.toggle3:
					data.setKeyValue("t3", (event.target as ToggleSwitch ).isSelected );
					break;	
			}
		}
		
		private function onTransitionComplete(ev:Event):void
		{
			if( (ev.target as ScreenNavigator ).activeScreen == this )
			{
				if( !this.data.keysInited )
				{
					this.data.addKeyValue( "t1", false );
					this.data.addKeyValue( "t2", false );
					this.data.addKeyValue( "t3", false );
					this.data.addKeyValue( "m", messageSync.text );	
					this.data.keysInited = true;
				}
				
				this.displayName.text = this.data.getDisplayName();
				this.sessionID.text = this.data.getSessionID();
				this.peerID.text = this.data.getPeerID();
				
				this.peerNamesList.dataProvider = new ListCollection(this.data.getConnectedPeersByName());
				this.peerIDList.dataProvider = new ListCollection( this.data.getConnectedPeersByID() );
				
				this.data.addEventListener(P2PDataEvent.DATA_RECEIVED, onDataReceived );
				
				this.connectionType.text = this.data.connectionType;
			}else
			{
				resetControls();
			}
		}
		
		private function onDataReceived(event:P2PDataEvent):void
		{
			this.toggle1.isSelected = data.getKeyValue("t1");
			this.toggle2.isSelected = data.getKeyValue("t2");
			this.toggle3.isSelected = data.getKeyValue("t3");
			this.messageSync.text = data.getKeyValue("m");
		}
	}
}
