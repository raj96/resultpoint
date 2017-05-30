package controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import dao.LoginDao;
import logic.LoginLogic;

/**
 * Servlet implementation class LoginCredReceiver
 */
@WebServlet("/controller.LoginCredReceiver")
public class LoginCredReceiver extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginCredReceiver() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		response.getWriter().append("Unauthorized Access");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		LoginDao dao = new LoginDao();
		dao.setEmail(request.getParameter("email"));
		dao.setPass(request.getParameter("password"));

		LoginLogic ll = new LoginLogic(dao);
		
		if(ll.checkPasswordisNull())
			response.getWriter().append("Password is Null");
		else
			response.getWriter().append("Password is OK");

		if(ll.insertData())
			response.getWriter().append("\nData Inserted");
		else
			response.getWriter().append("\nData Not Inserted");
	}

}
