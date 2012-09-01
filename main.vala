using SDL;
using SDLGraphics;
using Stk;
using Gee;

namespace Synergia
{
	public class Main
	{
		private const int SCREEN_WIDTH = 640;
		private const int SCREEN_HEIGHT = 480;
		private const int SCREEN_BPP = 32;
		private const int DELAY = 10;
		
		
		private ConnectWindow connect_window;
		private StatusWindow status;
		private Gee.List<Character> characters;
		private Label fpscount;
		private bool stop = false;
		private int fps = 0;
		
		public weak SDL.Screen screen;
		public NetConnector net;
		public Player self;
		public Map map;
		
		public Main()
		{
			this.init_video();
			this.init_network();
			
			this.net.events.error.connect(this.ErrorEvent);
			this.net.events.character.connect(this.CharacterEvent);
			this.net.events.character_out.connect(this.CharacterOutEvent);
			
			Stk.Stk.init(this.screen);
			Stk.Stk.events.quit.connect(this.quit);
			Stk.Stk.set_font("SegoeWP.ttf");
			
			this.self = new Player(this.net);
			this.characters = new ArrayList<Character>();
			this.connect_window = new ConnectWindow();
			this.fpscount = new Label.with_text("0");
			this.fpscount.halign = Alignment.LEFT;
			this.fpscount.valign = Alignment.TOP;
			
			this.connect_window.quit.connect(this.quit);
			this.connect_window.validate.connect(this.authenticate);
			
			Stk.Stk.events.tick.connect(this.update_fps);
			Stk.Stk.add_window(this.connect_window);
			
			Stk.Stk.workspace.add(new Image.from_file("gfx/menu.png"));
			Stk.Stk.workspace.add(this.fpscount);
		}
		
		public void run()
	    {
			while(!this.stop)
			{
				this.fps++;
				Stk.Stk.main_iteration();
				this.screen.flip();
				this.net.execute_commands();
				GLib.Thread.usleep(1000);
			}
		}
		
		public void update_fps()
		{
			this.fpscount.text = this.fps.to_string() + " fps";
			this.fps = 0;
		}
		
		public void quit()
		{
			this.stop = true;
		}
		
		public void clear()
		{
			this.net.close();
			SDLTTF.quit();
			SDL.quit();
		}
		
		public void authenticate()
		{
			
			Stk.Stk.remove_window(this.connect_window);
			this.status = new StatusWindow();
			this.status.message = "Connecting...";
			
			Stk.Stk.add_window(this.status);
			this.net.send("auth", { this.connect_window.username, Checksum.compute_for_string(ChecksumType.SHA1, this.connect_window.password) });
			this.net.send("set-character", { "1" });
			this.map = new Map(this.net, this.self, this.characters);
			Stk.Stk.workspace.clear();
			Stk.Stk.workspace.add(this.map);
			Stk.Stk.workspace.add(this.self);
			Stk.Stk.workspace.add(this.fpscount);
		}
		
		public void ErrorEvent(int errcode, string errstr)
		{
			if(errcode == 5)
				return;
			
			if(Stk.Stk.workspace.contains(this.status))
				Stk.Stk.workspace.remove(this.status);
			
			this.status = new StatusWindow();
			this.status.message = "Error #" + errcode.to_string() + ": " + errstr;
			
			Stk.Stk.add_window(this.status);
		}
		
		public void CharacterEvent(string[] command)
		{
			Character c = new Character(this.net);
			c.id = int.parse(command[0]);
			c.name = command[1];
			c.pos.x = (short)int.parse(command[2]);
			c.pos.y = (short)int.parse(command[3]);
			
			this.characters.add(c);
			Stk.Stk.workspace.add(c);
		}
		
		public void CharacterOutEvent(string[] command)
		{
			int id = int.parse(command[0]);
			foreach(Character c in this.characters)
			{
				if(c.id == id)
				{
					Stk.Stk.workspace.remove(c);
					this.characters.remove(c);
					break;
				}
			}
		}
		
		private void init_network()
		{
			this.net = new NetConnector();
			
			//Getting account server address
			string buffer;
			string[] addr;
			size_t len;
			
			var fp = File.new_for_path("address.txt");
			if(fp.query_exists())
			{
				var stream = fp.read();
				var dataStream = new DataInputStream(stream);
				buffer = dataStream.read_line(out len);
				addr = buffer.split(":");
				
				this.net.set_address(addr[0], int.parse(addr[1]));
			}
			
			this.net.connect_server();
		}
		
		private void init_video()
		{
			SDL.init(InitFlag.VIDEO);
			SDLTTF.init();
			
			uint32 video_flags =  SurfaceFlag.DOUBLEBUF
								| SurfaceFlag.ASYNCBLIT
								| SurfaceFlag.HWACCEL
								| SurfaceFlag.HWSURFACE
								| SurfaceFlag.SRCALPHA;

			

			this.screen = Screen.set_video_mode(SCREEN_WIDTH, SCREEN_HEIGHT,
											 SCREEN_BPP, video_flags);
			
			if(this.screen == null)
				GLib.error("Could not set video mode.");
			
			SDL.WindowManager.set_caption("Synergia", "");
			SDL.GL.set_attribute(GLattr.SWAP_CONTROL, 1);
		}
		
		public static int main(string[] args)
		{
			if (!GLib.Thread.supported()) {
		        stderr.printf("Cannot run without threads.\n");
		        return 1;
		    }
			
			Main m = new Main();
			
			m.run();
			m.clear();
			
			return 0;
		}
	}
}
