using SDL;
using SDLGraphics;
using Gee;
using SDLTTF;

namespace Stk
{
	public enum Alignment
	{
		LEFT, RIGHT, CENTER, TOP, MIDDLE, BOTTOM
	}
	
	public class Stk
	{
		private static weak Surface screen;
		private static Gee.List<Window> windows;
		
		public static Font font;
		
		public static Events events;
		public static Stack workspace;
		public static int ticks;
		public static bool drawing;
		
		public static void init(Surface screen)
		{
			Stk.ticks = 0;
			Stk.screen = screen;
			Stk.drawing = false;
			Stk.windows = new ArrayList<Window>();
			Stk.events = new Events();
			Stk.workspace = new Stack();
			
			Stk.workspace.rect.x = 0;
			Stk.workspace.rect.y = 0;
			
			Key.enable_unicode(1);
			Key.set_repeat(500, 50);
		}
		
		public static void add_window(Window w)
		{
			Stk.windows.add(w);
		}
		
		public static void remove_window(Window w)
		{
			Stk.windows.remove(w);
		}
		
		public static void clear_windows()
		{
			Stk.windows.clear();
		}
		
		public static void set_font(string fontfile)
		{
			if(Stk.font != null)
				Stk.font = null;
			Stk.font = new Font(fontfile, 12);
		}
		
		public static void draw()
		{
			
			uint32 rmask = 0xff000000u;
		    uint32 gmask = 0x00ff0000u;
		    uint32 bmask = 0x0000ff00u;
		    uint32 amask = 0x000000ffu;
		    Surface subscreen = new Surface.RGB(SurfaceFlag.HWSURFACE | SurfaceFlag.SRCALPHA, Stk.screen.w, Stk.screen.h, screen.format.BitsPerPixel, rmask, gmask, bmask, amask);
			subscreen.fill(null, subscreen.format.map_rgba(0, 0, 0, 0));
			Stk.drawing = true;
			Stk.workspace.draw(subscreen);
			subscreen.set_alpha(0, 0);
			subscreen.blit(null, Stk.screen, null);
			foreach(Window win in Stk.windows)
				win.draw(Stk.screen);
			
			Stk.drawing = false;
			
			Stk.ticks++;
			if(Stk.ticks == 60)
				Stk.ticks = 0;
		}
		
		public static void main_iteration()
		{
			draw();
			Stk.events.process();
		}
		
		public static uint32 color_to_uint32(Color c)
		{
			int ret = c.r;
			ret <<= 8;
			ret += c.g;
			ret <<= 8;
			ret += c.b;
			ret <<= 8;
			ret += c.unused;
			
			return ret;
		}
	}
}
