namespace Synergia
{
	public class NetConnector
	{
		public string address;
		public int port;
		
		public Socket socket;
		private unowned Thread<void*> readThread;
		private bool readLock = false;
		private string commands;
		
		public Events events;
		
		public NetConnector()
		{
			this.events = new Events();
			this.events.ping.connect(this.pingEvent);
			this.events.connect.connect(this.connectEvent);
		}
		
		public void set_address(string address, int port)
		{
			this.address = address;
			this.port = port;
		}
		
		public void connect_server()
		{
			if(this.address == null || this.port == 0)
				GLib.error("No address or port given.");
			
			SocketClient client = new SocketClient();
			SocketConnection connection;
			try
			{
				connection = client.connect_to_host(this.address, (uint16)this.port);
			}
			catch(GLib.Error e)
			{
				GLib.error("Can't connect to server.");
			}
			
			this.socket = connection.get_socket();
			this.socket.set_blocking(false);
			this.readThread = Thread.create<void*>(this.read, true);
		}
		
		//Sends data to the server.
		public void send_direct(string command)
		{
			if(!this.socket.is_connected())
				return;
			string query = command + "\n";
			stdout.printf("--> %s", query.replace("\x7F", ", "));
			try
			{
				this.socket.send(query.data);
			}
			catch(GLib.Error e)
			{
				stdout.printf("Can't send data.\n");
			}
		}
		
		public void send(string command, string[] params)
		{
			this.send_direct(command + ":" + string.joinv("\x7F", params));
		}
		
		public void close()
		{
			this.send_direct("quit");
			this.socket.close();
		}
		
		//Reads data from the server. Threaded.
		public void* read()
		{
			
			while(true)
			{
				string reply = "";
				uint8[] buffer;
				ssize_t len = 0;
				do
				{
					if(!this.socket.is_connected())
						Thread.exit(null);
						
					if(this.readLock == false)
					{
						buffer = new uint8[1024];
						try{
							len = this.socket.receive(buffer);
						}
						catch(GLib.Error e){
								break;
						}
						
						this.commands += (string)buffer;
					}
					Thread.usleep(5000);
				}
				while(len > 0);
				
				if(reply.length == 0)
					continue;
			}
		}
		
		public void execute_commands()
		{
			this.readLock = true;
			string[] commandList = this.commands.split("\n");
			this.commands = "";
			int i = 0;
			foreach(string cmd in commandList)
			{
				i++;
				if(cmd.length > 0 && i != commandList.length)
				{
					stdout.printf("<-- %s\n", cmd.replace("\x7F", ", "));
					string[] command = cmd.split(":", 2);
					this.events.raise(command[0], command[1].split("\x7F"));
				}
				else if(i == commandList.length && cmd.length > 0)
					this.commands += cmd;
			}
			this.readLock = false;
		}
		
		//Events callbacks
		
		public void pingEvent(string[] args)
		{
			this.send("pong", args);
		}
		
		public void connectEvent(string[] args)
		{
			this.close();
			this.set_address(args[1], int.parse(args[2]));
			this.connect_server();
			this.send("auth", { args[0] });
		}
	}
}
