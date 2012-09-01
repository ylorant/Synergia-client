using SDL;
using SDLGraphics;
using Stk;

namespace Synergia
{
	public class StatusWindow : Stk.Window
	{
		private Label label;
		
		public string message
		{
			get
			{
				return this.label.text;
			}
			set
			{
				this.label.text = value;
			}
		}
		
		public StatusWindow()
		{
			this.label = new Label();
			this.add(label);
			
			this.set_size(400, 140);
			this.set_position(120, 180);
		}
	}
}
