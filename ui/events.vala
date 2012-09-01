using SDL;

namespace Stk
{
	public class Events
	{
		public signal void mouseleft(MouseButtonEvent e);
		public signal void mousedown(MouseButtonEvent e);
		public signal void mouseup(MouseButtonEvent e);
		public signal void mousemove(MouseMotionEvent e);
		public signal void keydown(KeyboardEvent e);
		public signal void quit();
		public signal void tick();
		
		private uint32 mod = 0;
		
		public void process()
		{
			Event event = Event ();
	        while (Event.poll (out event) == 1)
	        {
	            switch (event.type)
	            {
					case EventType.MOUSEMOTION:
						this.mousemove(event.motion);
						break;
					case EventType.MOUSEBUTTONDOWN:
						this.mousedown(event.button);
						break;
					case EventType.MOUSEBUTTONUP:
						this.mouseup(event.button);
						switch(event.button.button)
						{
							case MouseButton.LEFT:
								this.mouseleft(event.button);
								break;
						}
						break;
					case EventType.QUIT:
						this.quit();
						break;
					case EventType.KEYDOWN:
						this.keydown(event.key);
						break;
	            }
	        }
	        
	        if((SDL.Timer.get_ticks() / 1000) % 2 != this.mod)
	        {
				this.mod = (SDL.Timer.get_ticks() / 1000) % 2;
				this.tick();
			}
		}
	}
}
