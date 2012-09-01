using SDL;
using SDLGraphics;
using Gee;

namespace Stk
{
	public class Container : Widget
	{
		protected Gee.List<Widget> widgets;
		
		public Container()
		{
			base();
			this.widgets = new ArrayList<Widget>();
		}
		
		public override bool draw(Surface screen)
		{
			base.draw(screen);
			
			if(this.widgets.size > 0)
			{
				int height = screen.h / this.widgets.size;
				int i = 0;
				uint32 rmask = 0xff000000u;
			    uint32 gmask = 0x00ff0000u;
			    uint32 bmask = 0x0000ff00u;
			    uint32 amask = 0x000000ffu;
				foreach(Widget w in this.widgets)
				{
					Surface subscreen = new Surface.RGB(SurfaceFlag.ASYNCBLIT | SurfaceFlag.HWSURFACE | SurfaceFlag.HWACCEL | SurfaceFlag.SRCALPHA, screen.w, height, screen.format.BitsPerPixel, rmask, gmask, bmask, amask);
					subscreen.fill(null, subscreen.format.map_rgba(0, 0, 0, 0));
					bool ret = w.draw(subscreen);
					subscreen.set_alpha(0, 0);
					subscreen.blit(null, screen, {0, (int16)(i * height)});
					
					if(ret)
					{
						w.rect.y = (int16)(this.rect.y + i * height);
						w.rect.x = this.rect.x;
					}
					else
					{
						w.rect.y += (int16)(this.rect.y + i * height);
						w.rect.x += this.rect.x;
					}
					
					
					i++;
				}
			}
			
			return true;
		}
		
		public void add(Widget w)
		{
			this.widgets.add(w);
		}
		
		public void remove(Widget w)
		{
			this.widgets.remove(w);
		}
		
		public void clear()
		{
			this.widgets.clear();
		}
		
		public bool contains(Widget w)
		{
			return this.widgets.contains(w);
		}
	}
}
