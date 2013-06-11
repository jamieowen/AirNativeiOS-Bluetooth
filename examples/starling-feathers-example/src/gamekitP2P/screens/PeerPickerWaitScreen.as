package gamekitP2P.screens {
	import feathers.controls.Button;
	import feathers.controls.Header;
	import feathers.controls.PanelScreen;
	import feathers.controls.ScreenNavigator;
	import feathers.events.FeathersEventType;
	import feathers.layout.VerticalLayout;

	import gamekitP2P.Main;
	import gamekitP2P.data.P2PData;
	import gamekitP2P.events.P2PDataEvent;

	import starling.events.Event;

	/**
	 * @author jamieowen
	 */
	public class PeerPickerWaitScreen extends PanelScreen
	{
		public var data:P2PData;
		
		public function PeerPickerWaitScreen()
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
				header.title = "Peer Picker Connect";
				
				return header;
			};
			
			if( StarlingFeathersExample.IS_TEST )
			{
				const skipButton:Button = new Button();
				skipButton.label = "Skip";
				skipButton.addEventListener( Event.TRIGGERED, onSkipTriggered );
				
				addChild( skipButton );
			}
			
			owner.addEventListener(FeathersEventType.TRANSITION_COMPLETE, onTransitionComplete );	
		}
		
		private function onSkipTriggered(event:Event):void
		{
			owner.showScreen( Main.SESSION_CONNECTED_SCREEN );
		}
		
		private function onTransitionComplete(ev:Event):void
		{
			if( (ev.target as ScreenNavigator ).activeScreen == this )
			{
				if( !StarlingFeathersExample.IS_TEST )
				{
					this.data.createPeerPicker();
					this.data.addEventListener( P2PDataEvent.PEER_PICKER_CANCELLED, onP2PDataEvent );
					this.data.addEventListener( P2PDataEvent.SESSION_CREATED, onP2PDataEvent );
				}
			}
		}	
		
		private function onP2PDataEvent(event:P2PDataEvent):void
		{	
			this.data.removeEventListener( P2PDataEvent.PEER_PICKER_CANCELLED, onP2PDataEvent );
			this.data.removeEventListener( P2PDataEvent.SESSION_CREATED, onP2PDataEvent );
							
			switch( event.type )
			{
				case P2PDataEvent.PEER_PICKER_CANCELLED:
					this.owner.showScreen( Main.CONNECT_OPTIONS_SCREEN );
					break;
					
				case P2PDataEvent.SESSION_CREATED:
					this.owner.showScreen( Main.SESSION_CONNECTED_SCREEN );
					break;
			}
		}
		
	}
}
