using SDL;
using SDLGraphics;
using Gee;

namespace Stk
{
	public class Stack : Container
	{
		public Stack()
		{
			base();
		}
		
		public void show(Widget w)
		{
			if(this.widgets.contains(w))
				this.widgets.remove(w);
			
			this.widgets.add(w);
		}
		
		public void hide(Widget w)
		{
			if(this.widgets.contains(w))
				this.widgets.remove(w);
			
			this.widgets.insert(0, w);
		}
		
		public new bool draw(Surface screen)
		{
			this.rect.w = (uint16)screen.w;
			this.rect.h = (uint16)screen.h;
			if(this.widgets.size > 0)
			{
				uint32 rmask = 0xff000000u;
			    uint32 gmask = 0x00ff0000u;
			    uint32 bmask = 0x0000ff00u;
			    uint32 amask = 0x000000ffu;
		    
				foreach(Widget w in this.widgets)
				{
					
					Surface subscreen = new Surface.RGB(SurfaceFlag.HWACCEL | SurfaceFlag.HWSURFACE | SurfaceFlag.SRCALPHA, screen.w, screen.h, screen.format.BitsPerPixel, rmask, gmask, bmask, amask);
					subscreen.fill(null, subscreen.format.map_rgba(0, 0, 0, 0));
					
					bool ret = w.draw(subscreen);
					
					subscreen.blit(w.rect, screen, w.rect);
					if(ret)
					{
						w.rect.y = this.rect.y;
						w.rect.x = this.rect.x;
					}
					else
					{
						w.rect.y += this.rect.y;
						w.rect.x += this.rect.x;
					}
					
					//~ subscreen.set_alpha(0, 0);
				}
			}
			
			return true;
		}
	}
}
