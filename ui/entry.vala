using SDL;
using SDLGraphics;
using Gee;

namespace Stk
{
	public class Entry : Widget
	{
		public Color border;
		public Color background;
		private bool prompted = false;
		private bool empty = true;
		
		public string text;
		public bool hidden = false;
		
		public signal void clicked();
		
		public Entry()
		{
			base();
			this.border = {0, 0, 0, 255};
			this.background = {255, 255, 255, 255};
			this.text = "";
			Stk.events.mouseleft.connect(this.onclick);
			Stk.events.keydown.connect(this.onkeypress);
		}
		
		public Entry.with_value(string text)
		{
			this();
			if(text != "")
			{
				this.empty = false;
				this.text = text;
			}
		}
		
		public void onclick()
		{
			if(this.focused)
				this.prompted = true;
			else
				this.prompted = false;
		}
		
		public void onkeypress(KeyboardEvent e)
		{
			if(this.prompted)
			{
				switch(e.keysym.sym)
				{
					case KeySymbol.RETURN:
						break;
					case KeySymbol.BACKSPACE:
						if(this.text.length > 1)
							this.text = this.text.substring(0, this.text.length - 1);
						else
						{
							this.text = "";
							this.empty = true;
						}
						break;
					default:
						this.empty = false;
						this.text += ((char)e.keysym.unicode).to_string();
						break;
				}
			}
		}
		
		public override bool draw(Surface screen)
		{
			base.draw(screen);
			
			string rendertext = this.text;
			if(this.hidden && !this.empty)
				rendertext = string.nfill(this.text.length, '*');
			else if(this.empty)
				rendertext = " ";
			
			Surface text = Stk.font.render_blended(rendertext, this.border);
			
			Rect dst = {
				2,
				(int16)(screen.h / 2 - text.h / 2 - 2),
				(int16)(screen.w - 4),
				(int16)(text.h + 3)
			};
			
			Rectangle.fill_color(screen, dst.x,
											dst.y,
											(int16)(dst.x + dst.w),
											(int16)(dst.y + dst.h),
											Stk.color_to_uint32(this.background));
			
			Rectangle.outline_color(screen, dst.x,
											dst.y,
											(int16)(dst.x + dst.w),
											(int16)(dst.y + dst.h),
											Stk.color_to_uint32(this.border));
			
			if(this.prompted && (SDL.Timer.get_ticks() / 1000)% 2 == 0)
			{
				if(!this.empty)
					Line.color_v(screen, (int16)(text.w <= (screen.w - 4) ? text.w + 4 : screen.w - 3), (int16)(screen.h / 2 - text.h / 2), (int16)(screen.h / 2 + text.h / 2), Stk.color_to_uint32(this.border));
				else
					Line.color_v(screen, 4, (int16)(screen.h / 2 - text.h / 2), (int16)(screen.h / 2 + text.h / 2), Stk.color_to_uint32(this.border));
			}
			
			this.rect = { dst.x, dst.y, dst.w, dst.h};			
			dst.x = (int16)(text.w > (screen.w - 4) ? (screen.w - text.w - 3) : 4);
			dst.y += 2;
			
			text.blit(null, screen, dst);
			
			return false;
		}
	}
}
