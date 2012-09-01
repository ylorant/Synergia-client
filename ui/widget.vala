using SDL;
using SDLGraphics;

namespace Stk
{
	public class Widget : Object
	{
		public Rect rect;
		protected bool focused = false;
		
		public signal void focus();
		public signal void blur();
		
		public virtual bool draw(Surface screen)
		{
			this.rect.w = (uint16)screen.w;
			this.rect.h = (uint16)screen.h;
			
			return true;
		}
		
		public Widget()
		{
			Stk.events.mousemove.connect(this.onmousemove);
		}
		
		public void onmousemove(MouseMotionEvent e)
		{
			if(this.collides(e.x, e.y) && !this.focused)
			{
				this.focus();
				this.focused = true;
			}
			else if(!this.collides(e.x, e.y) && this.focused)
			{
				this.blur();
				this.focused = false;
			}
		}
		
		protected bool collides(int x, int y)
		{
			return (x >= this.rect.x + 2 && y >= this.rect.y + 2 && x <= this.rect.x + this.rect.w - 4 && y <= this.rect.y + this.rect.h - 4);
		}
	}
}
