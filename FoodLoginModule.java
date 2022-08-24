import java.io.IOException;
import java.io.PrintWriter;
import java.io.FileInputStream;
import java.util.Properties;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.sql.*;
import javax.security.auth.Subject;
import javax.security.auth.callback.Callback;
import javax.security.auth.callback.CallbackHandler;
import javax.security.auth.callback.NameCallback;
import javax.security.auth.callback.PasswordCallback;
import javax.security.auth.callback.UnsupportedCallbackException;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.DB.DBOperation;

public class FoodLoginModule implements LoginModule {

	private CallbackHandler handler;
	private Subject subject;
	private UserPrincipal userPrincipal;
	private RolePrincipal rolePrincipal;
	private String login;
	private List<String> userGroups;
	private Properties pf = new Properties();
	private DBOperation db=new DBOperation();
	private ResultSet resultSet=null;

	@Override
	public void initialize(Subject subject, CallbackHandler callbackHandler,
			Map<String, ?> sharedState, Map<String, ?> options) {

		handler = callbackHandler;
		this.subject = subject;
	}

	@Override
	public boolean login() throws LoginException {

		Callback[] callbacks = new Callback[2];
		callbacks[0] = new NameCallback("login");
		callbacks[1] = new PasswordCallback("password", true);
		
		try {
			pf=db.propertyconnection();
		} 

		catch (Exception e) {
			e.printStackTrace();
		}

		try {
			handler.handle(callbacks);
			String name = ((NameCallback) callbacks[0]).getName();
			String password = String.valueOf(((PasswordCallback) callbacks[1])
					.getPassword());
			
			try {
				db.DBConnection();
				resultSet = db.selectall(pf.getProperty("table2"));
			}
			
			catch (SQLException e) {
				e.printStackTrace();
			}
			try{
				while (resultSet.next()) 
				{
					if ((name.equals(resultSet.getString(1))) && (password.equals(resultSet.getString(2)))) {
						if (name != null && name.equals("Admin") && password != null && password.equals("Zoho")) {
							login = name;
							userGroups = new ArrayList<String>();
							userGroups.add("admin");
							return true;
						} else {
							login = name;
							userGroups = new ArrayList<String>();
							userGroups.add("user");
							return true;

						}

					}
				}
				db.DBclose();
			} catch (Exception e) {
				e.printStackTrace();
			}

			throw new LoginException("Authentication failed");

		} catch (IOException e) {
			throw new LoginException(e.getMessage());
		} catch (UnsupportedCallbackException e) {
			throw new LoginException(e.getMessage());
		}

	}

	@Override
	public boolean commit() throws LoginException {

		userPrincipal = new UserPrincipal(login);
		subject.getPrincipals().add(userPrincipal);

		if (userGroups != null && userGroups.size() > 0) {
			for (String groupName : userGroups) {
				rolePrincipal = new RolePrincipal(groupName);
				subject.getPrincipals().add(rolePrincipal);
			}
		}

		return true;
	}

	@Override
	public boolean abort() throws LoginException {
		return false;
	}

	@Override
	public boolean logout() throws LoginException {
		subject.getPrincipals().remove(userPrincipal);
		subject.getPrincipals().remove(rolePrincipal);
		return true;
	}

}
