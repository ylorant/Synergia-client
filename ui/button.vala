using SDL;
using SDLGraphics;
using Gee;

namespace Stk
{
	public class Button : Widget
	{
		public Label label;
		public Color border;
		public Color background;
		
		public signal void clicked();
		
		public Button()
		{
			base();
			this.border = {0, 0, 0, 255};
			this.background = {255, 255, 255, 255};
			Stk.events.mouseleft.connect(this.onclick);
			Stk.events.mousedown.connect(this.onmousedown);
			Stk.events.mouseup.connect(this.onmouseup);
			this.focus.connect(this.onfocus);
			this.blur.connect(this.onblur);
		}
		
		public Button.with_text(string text)
		{
			this();
			this.label = new Label.with_text(text);
			this.label.translucent = true;
		}
		
		public void onclick(MouseButtonEvent e)
		{
			if(this.collides(e.x, e.y))
			{
				this.clicked();
			}
		}
		
		public void onmousedown(MouseButtonEvent e)
		{
			if(e.button == MouseButton.LEFT && this.collides(e.x, e.y))
			{
				this.label.color = {255, 255, 255, 255};
				this.border = {0, 0, 0, 255};
				this.background = {0, 0, 0, 255};
			}
		}
		
		public void onmouseup(MouseButtonEvent e)
		{
			if(e.button == MouseButton.LEFT)
			{
				
				if(this.focused)
				{
					this.border = {128, 128, 128, 255};
					this.label.color = {128, 128, 128, 255};
				}
				else
				{
					this.label.color = {0, 0, 0, 255};
					this.border = {0, 0, 0, 255};
				}
					
				this.background = {255, 255, 255, 255};
			}
		}
		
		public void onfocus()
		{
			this.border = {128, 128, 128, 255};
			this.label.color = {128, 128, 128, 255};
		}
		
		public void onblur()
		{
			this.border = {0, 0, 0, 255};
			this.label.color = {0, 0, 0, 255};
		}
		
		public override bool draw(Surface screen)
		{
			base.draw(screen);
			
			Rectangle.fill_color(screen, this.label.rect.x - 10,
											this.label.rect.y - 4,
											this.label.rect.x + this.label.rect.w + 10,
											this.label.rect.y + this.label.rect.h + 2,
											Stk.color_to_uint32(this.background));
			
			this.label.draw(screen);
			
			Rectangle.outline_color(screen, this.label.rect.x - 10,
											this.label.rect.y - 4,
											this.label.rect.x + this.label.rect.w + 10,
											this.label.rect.y + this.label.rect.h + 2,
											Stk.color_to_uint32(this.border));
											
			Rectangle.outline_color(screen, this.label.rect.x - 9,
											this.label.rect.y - 3,
											this.label.rect.x + this.label.rect.w + 9,
											this.label.rect.y + this.label.rect.h + 1,
											Stk.color_to_uint32(this.border));
			
			this.rect.x = this.label.rect.x - 12;
			this.rect.y = this.label.rect.y - 6;
			this.rect.w = this.label.rect.w + 26;
			this.rect.h = this.label.rect.h + 10;
			
			return false;
		}
	}
}
