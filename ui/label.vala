using SDL;
using SDLGraphics;

namespace Stk
{
	public class Label : Widget
	{
		public string text = " ";
		public bool translucent = false;
		public Color color;
		public Alignment halign = Alignment.CENTER;
		public Alignment valign = Alignment.MIDDLE;
		
		public Label()
		{
			base();
			this.color = {0, 0, 0, 255};
		}
		
		public Label.with_text(string text)
		{
			this();
			this.text = text;
		}
		
		public Label.colored_text(string text, Color color)
		{
			this.with_text(text);
			this.color = color;
		}
		
		public override bool draw(Surface screen)
		{
			base.draw(screen);
			if(this.text == " ")
				return false;
			Surface text = Stk.font.render_blended(this.text, this.color);
			
			
			Rect dst = Rect();
			
			switch(this.halign)
			{
				
				case Alignment.LEFT:
					dst.x = 1;
					break;
				case Alignment.RIGHT:
					dst.x = (int16)(screen.w - text.w - 1);
					break;
				case Alignment.CENTER:
				default:
					dst.x = (int16)(screen.w / 2 - text.w / 2);
					break;
			}
			
			switch(this.valign)
			{
				case Alignment.TOP:
					dst.y = 1;
					break;
				case Alignment.BOTTOM:
					dst.y = (int16)(screen.h - text.h - 1);
					break;
				case Alignment.MIDDLE:
				default:
					dst.y = (int16)(screen.h / 2 - text.h / 2);
					break;
			}
			
			if(!this.translucent)
				text.set_alpha(0, 0);
			text.blit(null, screen, dst);
			
			this.rect.x = dst.x;
			this.rect.y = dst.y;
			this.rect.w = (int16)text.w;
			this.rect.h = (int16)text.h;
			
			return false;
		}
	}
}
