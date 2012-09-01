using SDL;
using SDLGraphics;
using Stk;

namespace Synergia
{
	public class ConnectWindow : Stk.Window
	{
		private Entry usernameEntry;
		private Entry passwordEntry;
		
		public string username
		{
			get
			{
				return this.usernameEntry.text;
			}
			set
			{
				this.usernameEntry.text = value;
			}
		}
		
		public string password
		{
			get
			{
				return this.passwordEntry.text;
			}
			set
			{
				this.passwordEntry.text = value;
			}
		}
		
		public signal void quit();
		public signal void validate();
		
		public ConnectWindow()
		{
			this.usernameEntry = new Entry();
			this.passwordEntry = new Entry();
			HBox usernameBox = new HBox();
			HBox passwordBox = new HBox();
			HBox buttonBox = new HBox();
			Button connect = new Button.with_text("Connect");
			Button quit = new Button.with_text("Quit");
			Label usernameLbl = new Label.with_text("Username :");
			Label passwordLbl = new Label.with_text("Password :");
			
			this.passwordEntry.hidden = true;
			usernameLbl.halign = Alignment.RIGHT;
			passwordLbl.halign = Alignment.RIGHT;
			
			usernameBox.add(usernameLbl);
			usernameBox.add(this.usernameEntry);
			usernameBox.add(new Label());
			passwordBox.add(passwordLbl);
			passwordBox.add(this.passwordEntry);
			passwordBox.add(new Label());
			buttonBox.add(new Label());
			buttonBox.add(connect);
			buttonBox.add(quit);
			buttonBox.add(new Label());
			
			
			this.add(usernameBox);
			this.add(passwordBox);
			this.add(buttonBox);
			this.add(new Label());
			
			this.set_size(400, 200);
			this.set_position(120, 240);
			this.title = "Connect";
			this.opacity = 0;
			
			connect.clicked.connect(this.onConnectClick);
			quit.clicked.connect(this.onQuitClick);
		}
		
		public void onQuitClick()
		{
			this.quit();
		}
		
		public void onConnectClick()
		{
			this.validate();
		}
	}
}
