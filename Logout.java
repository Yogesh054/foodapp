import java.io.IOException;
import java.io.FileInputStream;
import java.util.Properties;
import com.DB.*;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class Logout extends HttpServlet {
	private static final long serialVersionUID = 1L;
    
	private Properties pf = new Properties();
    private DBOperation db=new DBOperation();
        
	protected void doGet(HttpServletRequest request,
			HttpServletResponse response)
			throws ServletException, IOException {

				try {
					DBOperation db=new DBOperation();
					pf=db.propertyconnection();
				} 
				
				catch (Exception e) {
					e.getMessage();
				}

				response.sendRedirect(pf.get("host")+pf.getProperty("index"));
				request.getSession().invalidate();

	}

}
