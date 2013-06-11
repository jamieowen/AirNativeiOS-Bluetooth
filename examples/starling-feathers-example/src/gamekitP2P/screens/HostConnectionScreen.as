package gamekitP2P.screens {
	import gamekitP2P.Main;
	import starling.display.DisplayObject;
	import starling.events.Event;
	import feathers.controls.Button;
	import gamekitP2P.data.P2PData;
	import feathers.controls.Header;
	import feathers.layout.VerticalLayout;
	import feathers.controls.PanelScreen;

	/**
	 * @author jamieowen
	 */
	public class HostConnectionScreen extends PanelScreen
	{
		
		public var data:P2PData;
		
		public function HostConnectionScreen()
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
				header.title = "Host a GKSession";
				
				const backButton:Button = new Button();
				backButton.label = "Back";
				backButton.addEventListener(Event.TRIGGERED, onButtonTriggered);
				backButton.name = "backButton";
				
				const rightItems:Vector.<DisplayObject> = new Vector.<DisplayObject>();
				rightItems.push(backButton);
				header.rightItems = rightItems;
				
				return header;
			};
			
		}
		
		private function onButtonTriggered(ev:Event):void
		{	
			var button:Button = ev.target as Button;
			if( !button )
				return;
			
			if( button.nameList.contains("backButton") )
			{
				owner.showScreen( Main.CONNECT_OPTIONS_SCREEN );	
			}else
			{
				
			}
		}	
	}
}
