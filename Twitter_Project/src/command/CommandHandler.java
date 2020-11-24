package command;

import java.util.HashMap;

public class CommandHandler {
	HashMap<String, String> command = new HashMap<String, String>();
	public CommandHandler() {
		command.put("login", "controller.LoginController");
		command.put("logout", "controller.LogoutController");
		command.put("signUp", "controller.SignUpController");
		command.put("profile", "controller.ProfileController");
		command.put("write", "controller.TwitWriteController");
		command.put("delete", "controller.TwitDeleteController");
		command.put("searchID", "controller.SearchIDController");
		command.put("pwReset", "controller.PwResetController");
		command.put("pwChange", "controller.PwChangeController");
	}
	
	public Command getCommand(String cmd) {
		String strClass = command.get(cmd);
		Command cmdClass = null;
		try {
			cmdClass = (Command) Class.forName(strClass).newInstance();
		} catch (InstantiationException | IllegalAccessException | ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return cmdClass;
	}
}
