using SDL;
using SDLGraphics;
using SDLTTF;
using SDLImage;

namespace Stk
{
	public class Window : Container
	{
		public Color background;
		public Color titlebg;
		public Color border;
		public string title;
		public uchar opacity = 255;
		public bool bubble = false;
		
		public Window()
		{
			base();
			this.title = "";
			this.rect = Rect();
			this.background = {255, 255, 255, 255};
			this.border = {0, 0, 0, 255};
		}
		
		public new bool draw(Surface screen)
		{
			uint32 rmask = 0xff000000u;
		    uint32 gmask = 0x00ff0000u;
		    uint32 bmask = 0x0000ff00u;
		    uint32 amask = 0x000000ffu;
		    
		    if(this.title == "")
				this.rect.y -= 20;
		    
			Surface subsurface = new Surface.RGB(SurfaceFlag.HWSURFACE | SurfaceFlag.HWACCEL | SurfaceFlag.SRCALPHA, this.rect.w, this.rect.h, screen.format.BitsPerPixel, rmask, gmask, bmask, amask);
			Surface background = new Surface.RGB(SurfaceFlag.HWACCEL | SurfaceFlag.HWSURFACE, this.rect.w, this.rect.h, screen.format.BitsPerPixel,0, 0, 0, 0);
			
			background.fill(null, Stk.color_to_uint32(this.background));
			base.draw(subsurface);
			
			background.set_alpha(SurfaceFlag.SRCALPHA, this.opacity);
			if(!this.bubble)
			{
				background.blit(null, screen, this.rect);
				subsurface.blit(null, screen, this.rect);
			}
			else
			{
				subsurface.blit(null, background, null);
				background.blit(null, screen, this.rect);
			}
			
			int16 ypos;
			
			if(this.title != "")
			{
				Surface titlebar = new Surface.RGB(SurfaceFlag.HWACCEL | SurfaceFlag.HWSURFACE, this.rect.w, 20, screen.format.BitsPerPixel, 0, 0, 0, 0);
				titlebar.fill(null, Stk.color_to_uint32(this.background));
				titlebar.set_alpha(SurfaceFlag.SRCALPHA, this.opacity);
				
				this.border.unused = this.opacity;
				
				if(Stk.font != null && this.title != "")
				{
					Surface title = Stk.font.render_blended(this.title, this.border);
					title.blit(null, titlebar, {4, 1});
				}
				
				Rect dst = {this.rect.x, this.rect.y - 20, this.rect.w, 20};
				titlebar.blit(null, screen, dst);
				ypos = (int16)this.rect.y - 20;
			}
			else
				ypos = this.rect.y;
			
			Rectangle.outline_color(screen, (int16)this.rect.x, ypos, (int16)(this.rect.w + this.rect.x), (int16)(this.rect.h + this.rect.y), Stk.color_to_uint32(this.border));
			
			if(this.title == "")
				this.rect.y += 20;
			
			return false;
		}
		
		public void set_size(int width, int height)
		{
			this.rect.w = (int16)width;
			this.rect.h = (int16)height;
		}
		
		public void set_position(int x, int y)
		{
			this.rect.x = (int16)x;
			this.rect.y = (int16)y + 20;
		}
	}
}
