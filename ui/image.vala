using SDL;
using SDLGraphics;
using SDLImage;
using Gee;

namespace Stk
{
	public class Image : Widget
	{
		private Surface image;
		
		public Image()
		{
			base();
		}
		
		public Image.from_file(string file)
		{
			this.image = SDLImage.load(file);
		}
		
		public override bool draw(Surface screen)
		{
			base.draw(screen);
			
			if(this.image != null)
			{
				Rect dst = {
					(int16)(screen.w / 2 - image.w / 2),
					(int16)(screen.h / 2 - image.h / 2)
				};
				
				this.image.set_alpha(0, 0);
				this.image.blit(null, screen, dst);
			}
			
			return true;
		}
	}
}
