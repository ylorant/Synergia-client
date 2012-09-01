using SDL;
using SDLGraphics;

namespace Stk
{
	class HBox : Container
	{
		public override bool draw(Surface screen)
		{
			this.rect.w = (uint16)screen.w;
			this.rect.h = (uint16)screen.h;
			
			if(this.widgets.size > 0)
			{
				int width = screen.w / this.widgets.size;
				int i = 0;
				uint32 rmask = 0xff000000u;
			    uint32 gmask = 0x00ff0000u;
			    uint32 bmask = 0x0000ff00u;
			    uint32 amask = 0x000000ffu;
				foreach(Widget w in this.widgets)
				{
					Surface subscreen = new Surface.RGB(SurfaceFlag.HWACCEL | SurfaceFlag.HWSURFACE | SurfaceFlag.SRCALPHA, width, screen.h, screen.format.BitsPerPixel, rmask, gmask, bmask, amask);
					subscreen.fill(null, subscreen.format.map_rgba(0, 0, 0, 0));
					bool ret = w.draw(subscreen);
					subscreen.set_alpha(0, 0);
					subscreen.blit(null, screen, {(int16)(i * width), 0});
					
					if(ret)
					{
						w.rect.x = (int16)(this.rect.x + i * width);
						w.rect.y = this.rect.y;
					}
					else
					{
						w.rect.x += (int16)(this.rect.x + i * width);
						w.rect.y += this.rect.y;
					}
					
					i++;
				}
			}
			
			return true;
		}
	}
}
